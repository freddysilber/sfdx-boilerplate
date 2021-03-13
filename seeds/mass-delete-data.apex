// Database.executeBatch(new DeleteRecordsBatch('SELECT Id FROM project_cloud__Project__c WHERE Name LIKE \'%inserted from DataLoader%\''), 2);
Set<SObjectType> sobjectTypes = new Set<SObjectType>{
	Project__c.SObjectType,
	Project_Settings__c.SObjectType,
	Area__c.SObjectType,
	Work_Type__c.SObjectType,
	Stakeholder_Contact__c.SObjectType,
	KPI_Area__c.SObjectType,
	Stage_Gate_Process__c.SObjectType,
	Board_Process__c.SObjectType,
	Milestone_Process__c.SObjectType
};

for (SObjectType sobjectType : sobjectTypes) {
	Database.executeBatch(new DeleteRecordsBatch('SELECT Id FROM ' + String.valueOf(sobjectType)), 2);	
}