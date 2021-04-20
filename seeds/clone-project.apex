delete [SELECT Id FROM Project__c WHERE Id != 'a0pN0000006n0tpIAA'];

Project__c project = [
	SELECT 
		Name,
		Location__c, 
		Start__c, 
		Type__c,
		Units__c,
		Monthly_Expenses__c,
		IsWorking_Monday__c, 
		IsWorking_Tuesday__c,
		IsWorking_Wednesday__c,
		IsWorking_Thursday__c, 
		IsWorking_Friday__c, 
		IsWorking_Saturday__c,
		IsWorking_Sunday__c
	FROM Project__c
	WHERE Id = 'a0pN0000006n0tpIAA'
	LIMIT 1
];

project.Name = project.Name + ' - Clone';

CloneHelper.cloneProject(
	project,
	Date.today(), 
	new Set<CloneHelper.Option>{
		CloneHelper.Option.CloneTickets, 
		CloneHelper.Option.CloneCases, 
		CloneHelper.Option.CloneSubscriptions, 
		CloneHelper.Option.CloneExpenses, 
		CloneHelper.Option.CloneSkills, 
		CloneHelper.Option.IsBatch
	}
);