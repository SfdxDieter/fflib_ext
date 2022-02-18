/**
 * DispatchTriggerHandlerTest
 */

@IsTest(IsParallel=false)
private class DispatchTriggerHandlerTest {
    @IsTest
    static void testBehavior() {
        TriggerDispatchSelectorTest.createDemoData();

        Case c = new Case();
        c.Subject = 'Test1';
        fflib_SObjectDomain.Test.Database.onInsert(new Case[] { c } );
        DispatchTriggerHandler.triggerHandler(Case.class);

        System.assertEquals(1, DispatchTriggerHandler.getTriggerEvent(Case.class).size());

        DemoCaseTriggerHandler.throwException = true;
        try {
            Test.startTest();
            DispatchTriggerHandler.triggerHandler(Case.class);
            Test.stopTest();
        } catch (Exception mathException) {
            System.assert(String.isNotBlank(mathException.getMessage()));
        }

        DispatchTriggerHandler.disableAllTriggerEvents(Case.class);
        DispatchTriggerHandler.triggerHandler(Case.class);
        System.assertEquals(1, DispatchTriggerHandler.getTriggerEvent(Case.class).size());
    }

    @IsTest
    static void testBehavior2() {
        TriggerDispatchSelectorTest.createDemoData();

        Case c = new Case();
        c.Subject = 'Test1';
        fflib_SObjectDomain.Test.Database.onInsert(new Case[] { c } );

        DispatchTriggerHandler.triggerHandler(Case.class);

        System.assertEquals(1, DispatchTriggerHandler.getTriggerEvent(Case.class).size());

        DemoCaseTriggerHandler.throwException = true;
        try {
            Test.startTest();
            DispatchTriggerHandler.triggerHandler(Case.class);
            Test.stopTest();
        } catch (Exception mathException) {
            System.assert(String.isNotBlank(mathException.getMessage()));
        }
        DispatchTriggerHandler.disableAllTriggerEvents();
        DispatchTriggerHandler.triggerHandler(Case.class);
        System.assertEquals(1, DispatchTriggerHandler.getTriggerEvent(Case.class).size());
    }

    @IsTest
    static void testBehavior3() {
        TriggerDispatchSelectorTest.createDemoData();

        Case c = new Case();
        c.Subject = 'Test1';
        fflib_SObjectDomain.Test.Database.onInsert(new Case[] { c } );

        DispatchTriggerHandler.triggerHandler(Case.class);

        System.assertEquals(1, DispatchTriggerHandler.getTriggerEvent(Case.class).size());

        DemoCaseTriggerHandler.throwException = true;
        DispatchTriggerHandler.enableAllTriggerEvents();
        try {
            Test.startTest();
            DispatchTriggerHandler.triggerHandler(Case.class);
            Test.stopTest();
        } catch (Exception mathException) {
            System.assert(String.isNotBlank(mathException.getMessage()));
        }
    }
}