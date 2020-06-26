public with sharing class ProjectSeedingBatch implements Database.Batchable<sObject>, Database.Stateful {

	public Arguments args{ get; set; }
	
	public ProjectSeedingBatch(Arguments args) {
		this.args = args;
	}

	public ProjectSeedingBatch(String projectName, Integer phasesCount, Integer tasksCount, Boolean withDependencies, Boolean longTasks) {
		this.args = new Arguments(projectName, phasesCount, tasksCount, 'somePrefix', withDependencies, longTasks);
	}

	private static Date safeToday = ProjectSeedingBatch.getSafeDate(0);
	private Id previousId;

	public Iterable<sObject> start(Database.BatchableContext BC) {
		project_cloud__Project__c proj = generateProject(args.projectName);
		insert proj;
		List<project_cloud__Project_Phase__c> phases = generatePhases(proj.Id, args.phasesCount);
		insert phases;
		List<project_cloud__Project_Task__c> tasks = new List<project_cloud__Project_Task__c>();
		for (project_cloud__Project_Phase__c p : phases) {
			for (Integer i = 0; i < args.tasksCount; i++) {
				tasks.add(generateProjectTask(p.Id, false));
			}
		}
		return tasks;
	}
	 
	public void execute(Database.BatchableContext BC, List<project_cloud__Project_Task__c> tasks) {
	   insert tasks;
	   if (args.withDependencies) {
		List<project_cloud__Project_Task_Dependency__c> deps = new List<project_cloud__Project_Task_Dependency__c>();
		for (project_cloud__Project_Task__c t : tasks) {
			if (previousId != null) {
				deps.add(new project_cloud__Project_Task_Dependency__c(
					project_cloud__Parent__c = previousId, 
					project_cloud__Child__c = t.Id
				));
			}
			previousId = t.Id;
		}
		insert deps;
	   }
	   //ProjectSeeding.generateSampleGanttLoad(args.projectsCount, args.phasesCount, args.tasksCount, args.prefix, args.withDependencies, args.longTasks);
	}   
	 
	public void finish(Database.BatchableContext BC) {
		// execute any post-processing operations
  	}

	private project_cloud__Project__c generateProject(String name) {
		project_cloud__Project__c project = new project_cloud__Project__c();
		project.Name = name;
		project.project_cloud__IsWorking_Monday__c = true;
		project.project_cloud__IsWorking_Tuesday__c = true;
		project.project_cloud__IsWorking_Wednesday__c = true;
		project.project_cloud__IsWorking_Thursday__c = true;
		project.project_cloud__IsWorking_Thursday__c = true;
		project.project_cloud__IsWorking_Friday__c = true;
		project.project_cloud__IsWorking_Saturday__c = false;
		project.project_cloud__IsWorking_Sunday__c = false;
		return project;
	}

	private List<project_cloud__Project_Phase__c> generatePhases(Id projectId, Integer count) {
		List<project_cloud__Project_Phase__c> phases = new List<project_cloud__Project_Phase__c>();
		for (Integer i = 0; i < count; i++) {
			phases.add(new project_cloud__Project_Phase__c(
				Name = 'Phase ' + (i + 1), 
				project_cloud__Project__c = projectId
			));
		}
		return phases;
	}

	private static project_cloud__Project_Task__c generateProjectTask(Id phaseId, Boolean longTask) {
		Integer taskMinRange = longTask ? 8 : 2;
		Integer taskMaxRange = longTask ? 2000 : 140;
		project_cloud__Project_Task__c newTask = new project_cloud__Project_Task__c();

		newTask.Name = 'Task-' + System.currentTimeMillis();
		newTask.project_cloud__Autonomous_Start__c = safeToday;
		newTask.project_cloud__Project_Phase__c = phaseId;
		newTask.project_cloud__Units__c = 'Estimated Hours';
		newTask.project_cloud__Estimated_Hours__c = generateRandomFromRange(taskMinRange, taskMaxRange);
		return newTask;
	}

	public static Date getSafeDate(Long increment) {
		Date today = Date.today();
		return today + getSafeIncrement(increment, today);
	}

	private static final Date longTimeAgoMonday = Date.newInstance(1, 1, 3);

	private static Integer getDayOfWeek(Date value) {
		return Math.mod(Date.newInstance(1, 1, 3).daysBetween(value), 7);
	}

	private static Long getSafeIncrement(Long increment, Date start) {
		Date moved = (start != null ? start : Date.today()) + increment;
		Integer dayOfWeek = getDayOfWeek(moved);
		//Sat/Sun
		if (dayOfWeek > 4) {
			//Sat: 2 - MAX(0, 5 - 5) = 2
			//Sun: 2 - MAX(0, 6 - 5) = 1
			return increment + 2 - Math.max(0, dayOfWeek - 5);
		}
		return increment;
	}

	private static Integer generateRandomFromRange(Integer startNum, Integer endNum) {
		Integer returnValue;
		Integer randomNumber = Integer.valueof((Math.random() * 10));
		Boolean addSubFlag= Math.mod(randomNumber, 2) == 0 ? true : false;
		Integer diffInRange = endNum - startNum;
		Integer randomNum = Math.mod(Math.round(Math.random() * diffInRange + 1), diffInRange);
		if (addSubFlag) {
			if (diffInRange > 1) {
				returnValue = startNum + randomNum;
			} else {
				returnValue = startNum;
			}
		} else {
			if (diffInRange > 1) {
				returnValue = endNum - randomNum;
			} else {
				returnValue = endNum;
			}
		}
		return returnValue;
	}    

	public class Arguments {
		public String projectName { get; set; }
		public Integer phasesCount { get; set; }
		public Integer tasksCount { get; set; }
		public String prefix { get; set; }
		public Boolean withDependencies { get; set; }
		public Boolean longTasks { get; set; }

		public Arguments(String projectName, Integer phasesCount, Integer tasksCount, String prefix, Boolean withDependencies, Boolean longTasks) {
			this.projectName = projectName;
			this.phasesCount = phasesCount;
			this.tasksCount = tasksCount;
			this.prefix = prefix;
			this.withDependencies = withDependencies;
			this.longTasks = longTasks;
		}
	}
}