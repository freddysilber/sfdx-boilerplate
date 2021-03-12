Boolean isTemplate = true;
Date startDate = System.today().toStartOfWeek().addDays(1);
String[] taskColors = new String[]{
	'Magenta', 
	'Pink', 
	'Burgundy', 
	'Orange', 
	'Yellow', 
	'Green', 
	'Blue', 
	'Purple'
};

project_cloud__Project__c project = new project_cloud__Project__c(
	Name = 'Freddys Project',
	project_cloud__Units__c = 'Duration',
	project_cloud__IsTemplate__c = isTemplate
);
insert project;

project_cloud__Project_Phase__c[] phaseList = new project_cloud__Project_Phase__c[]{};
for (Integer i = 0; i < 5; i++) {
	phaseList.add(new project_cloud__Project_Phase__c(
		Name = 'Freddys Phase: ' + i,
		project_cloud__Project__c = project.Id
	));
}
insert phaseList;

project_cloud__Project_Task__c[] taskList = new project_cloud__Project_Task__c[]{};
Integer counter = 0;
for (project_cloud__Project_Phase__c phase : phaseList) {
	for (Integer t = 0; t < taskColors.size(); t++) {
		taskList.add(new project_cloud__Project_Task__c(
			Name = 'Freddys Task: ' + counter + ' | ' + t,
			project_cloud__Project_Phase__c = phase.Id,
			project_cloud__Estimated_Hours__c = 80,
			project_cloud__Duration__c = 10,
			project_cloud__Color__c = taskColors[t],
			project_cloud__Autonomous_Start__c = startDate
		));
	}
	counter ++;
}
insert taskList;