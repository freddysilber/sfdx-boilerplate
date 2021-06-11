Schema.SObjectType sobjectType = Project__c.SObjectType;

String query = '';
query += 'SELECT Id ';
query += 'FROM ' + getNamespace('__') + sobjectType.getDescribe().getName();
query += ' '; // Give space for an optional WHERE clause

String whereClause;
whereClause != '';

Database.executeBatch(new DeleteRecordsBatch(query), 2);

private static String getNamespace(String seperator) {
	return getNamespace() + seperator;
}

private static String getNamespace() {
	return 'project_cloud';
}