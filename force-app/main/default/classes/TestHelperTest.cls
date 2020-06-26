@isTest
public with sharing class TestHelperTest {
    // Test that the Project object is not null
    static testMethod void testNewProject() {
        Test.startTest();
            System.assertNotEquals(null, TestHelper.newProject(TestHelper.PROJECT_NAME));
        Test.stopTest();
    }
    // Test that the Phase record object is not null
    static testMethod void testNewPhase() {
        Test.startTest();
            System.assertNotEquals(null, TestHelper.newPhase(TestHelper.PHASE_NAME, createProject()));
        Test.stopTest();
    }
    // Test that the Phase list is not null
    static testMethod void testNewPhaseList() {
        Test.startTest();
            project_cloud__Project__c project = createProject();
            insert project;
            System.assertNotEquals(null, TestHelper.newPhaseList(TestHelper.PHASE_NAME, 5, project));
        Test.stopTest();
    }
    // Test that the Task list is not null
    static testMethod void testNewTaskList() {
        Test.startTest();
            project_cloud__Project__c project = createProject();
            insert project;
            project_cloud__Project_Phase__c[] phaseList = TestHelper.newPhaseList(TestHelper.PHASE_NAME, 5, project);
            insert phaseList;
            System.assertNotEquals(null, TestHelper.newTaskList(TestHelper.TASK_NAME, 5, phaseList));
        Test.stopTest();
    }
    // Test that the Project Task object is not null
    static testMethod void testNewTask() {
        Test.startTest();
            System.assertNotEquals(null, TestHelper.newTask(TestHelper.TASK_NAME, TestHelper.newPhase(TestHelper.PHASE_NAME, createProject())));
        Test.stopTest();
    }
    // Test that the query does not return null
    static testMethod void testGetProjectByName() {
        Test.startTest();
            insert createProject();
            System.assertNotEquals(null, TestHelper.getProjectByName(TestHelper.PROJECT_NAME));
        Test.stopTest();
    }
    // Test that the query does not return null
    static testMethod void testGetPhaseByName() {
        Test.startTest();
            project_cloud__Project__c project = createProject();
            insert project;
            insert createPhase(project);
            System.assertNotEquals(null, TestHelper.getPhaseByName(TestHelper.PHASE_NAME));
        Test.stopTest();
    }
    // Helper method to create a new Project object for testing
    private static project_cloud__Project__c createProject() {
        return TestHelper.newProject(TestHelper.PROJECT_NAME);
    }
    // Helper method to create a new Phase object for testing
    private static project_cloud__Project_Phase__c createPhase(project_cloud__Project__c project) {
        return TestHelper.newPhase(TestHelper.PHASE_NAME, project);
    }
}
