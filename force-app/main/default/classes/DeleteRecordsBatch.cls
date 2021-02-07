public class DeleteRecordsBatch implements Database.Batchable<SObject> {

    public String query;
    
    public DeleteRecordsBatch(String query) {
        this.query = query;
    }
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator(this.query);
    }
    
    public void execute(Database.BatchableContext bc, SObject[] records){
		try {
        	delete records;
		} catch (Exception e) { }
    }
    
    public void finish(Database.BatchableContext bc) { }
}

// String dataloader = '%inserted from DataLoader%';
// Database.executeBatch(new DeleteRecordsBatch('SELECT Id FROM project_cloud__Project__c WHERE Name LIKE \'%inserted from DataLoader%\''), 2);