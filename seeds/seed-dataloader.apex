String projectName = 'Sample Project';
Integer phaseCount = 2, taskCount = 3;
Boolean deletePrevious = true;

if (deletePrevious) {
	try {
		delete [SELECT Id FROM Project__c WHERE Name = :projectName LIMIT 1];
	} catch(Exception e) { }
}

Project__c project = new Project__c(
	Name = projectName
);
insert project;

Project_Phase__c[] phases = new Project_Phase__c[]{};

for (Integer i = 0; i < phaseCount; i++) {
	phases.add(new Project_Phase__c(
		Name = projectName + ' - Phase ' + i,
		Project__c = project.Id
	));
}

insert phases;

Project_Task__c[] tasks = new Project_Task__c[]{};

Integer phaseIndex = 0;
for (Project_Phase__c phase : phases) {
	for (Integer i = 0; i < taskCount; i++) {
		tasks.add(new Project_Task__c(
			Name = projectName + ' - Task ' + phaseIndex + ' | ' + i,
			Duration__c = 2,
			Estimated_Hours__c = 3,
			Project_Phase__c = phase.Id,
			Autonomous_Start__c = Date.today()
		));
	}
	phaseIndex++;
}

insert tasks;