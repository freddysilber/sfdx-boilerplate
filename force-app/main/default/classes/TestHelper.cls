public with sharing class TestHelper {
    // These variables can be used in test methods to garuntee consistant testing methods and data
    public static final String PROJECT_NAME = 'Test Project';
    public static final String PHASE_NAME = 'Test Phase';
    public static final String TASK_NAME = 'Test Task';
    public static final Date SAFE_DATE = Date.today().toStartOfWeek().addDays(1);
    // This method returns a new Project object that can be inserted in a @TestSetup method testMethod method
    public static project_cloud__Project__c newProject(String projectName) {
        return new project_cloud__Project__c(
            Name = projectName,
            project_cloud__Units__c = 'Duration'
        );
    }
    // This method returns a new Phase object that can be inserted in a @TestSetup method or testMethod method
    public static project_cloud__Project_Phase__c newPhase(String phaseName, project_cloud__Project__c project) {
        return new project_cloud__Project_Phase__c(
            Name = phaseName,
            project_cloud__Project__c = project.Id
        );
	}
    // This method returns a list of new Phase objects for test data
    public static project_cloud__Project_Phase__c[] newPhaseList(String phaseName, Integer recordCount, project_cloud__Project__c project) {
        project_cloud__Project_Phase__c[] phaseList = new project_cloud__Project_Phase__c[]{};
        for (Integer i = 0; i < recordCount; i++) {
            phaseList.add(new project_cloud__Project_Phase__c(
                Name = phaseName + ' ' + i,
                project_cloud__Project__c = project.Id
            ));
        }
        return phaseList;
    }
    // This method returns a list of new Project Task objects for test data
    public static project_cloud__Project_Task__c[] newTaskList(String taskName, Integer recordCount, project_cloud__Project_Phase__c[] parentPhases) {
        project_cloud__Project_Task__c[] taskList = new project_cloud__Project_Task__c[]{};
        for (project_cloud__Project_Phase__c phase : parentPhases) {
            for (Integer i = 0; i < recordCount; i++) {
                taskList.add(new project_cloud__Project_Task__c(
                    Name = taskName + ' ' + i,
                    project_cloud__Project_Phase__c = phase.Id,
                    project_cloud__Duration__c = 1,
                    project_cloud__Estimated_Hours__c = 1,
                    project_cloud__Autonomous_Start__c = SAFE_DATE
                ));
            }
        }
        return taskList;
    }
	// This method returns a new Project Task object that can be inserted in a @TestSetup method to testMethod method
	public static project_cloud__Project_Task__c newTask(String taskName, project_cloud__Project_Phase__c phase) {
		return new project_cloud__Project_Task__c(
			Name = taskName,
			project_cloud__Project_Phase__c = phase.Id,
			project_cloud__Duration__c = 1,
			project_cloud__Estimated_Hours__c = 1,
			project_cloud__Autonomous_Start__c = SAFE_DATE
		);
	}
    // This method returns a single Project object queried by the Name field
    public static project_cloud__Project__c getProjectByName(String projectName) {
        return [SELECT Id FROM project_cloud__Project__c WHERE Name = :projectName LIMIT 1];
    }
    // This method returns a single phase object by name
    public static project_cloud__Project_Phase__c getPhaseByName(String phaseName) {
        return [SELECT Id FROM project_cloud__Project_Phase__c WHERE Name = :phaseName LIMIT 1];
    }
}