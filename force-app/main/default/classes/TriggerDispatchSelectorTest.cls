/**
 * TriggerDispatchSelectorTest
 */

@IsTest(IsParallel=false)
public class TriggerDispatchSelectorTest {

    public static void createDemoData() {
        TriggerDispatchSelector.OverwriteActiveTriggerDispatch = new List<TriggerDispatch__mdt>();
        TriggerDispatch__mdt item = new TriggerDispatch__mdt();
        item.ApexClass__c = DemoCaseTriggerHandler.class.getName();
        item.SObjectName__c = Case.class.getName();
        TriggerDispatchSelector.OverwriteActiveTriggerDispatch.add(item);
        TriggerDispatch__mdt item2 = new TriggerDispatch__mdt();
        item2.ApexClass__c = 'NeverFoundClass';
        item2.SObjectName__c = Case.class.getName();
        TriggerDispatchSelector.OverwriteActiveTriggerDispatch.add(item2);
    }

    @IsTest
    static void testBehavior() {
        TriggerDispatchSelector selector = new TriggerDispatchSelector();
        Test.startTest();
        createDemoData();
        List<TriggerDispatch__mdt> data = selector.getActiveTriggerDispatch();
        Test.stopTest();
        System.assertEquals(2, data.size());

    }

    @IsTest
    static void testBehavior2() {
        TriggerDispatchSelector selector = new TriggerDispatchSelector();
        Test.startTest();
        TriggerDispatchSelector.OverwriteActiveTriggerDispatch = null;
        List<TriggerDispatch__mdt> data = selector.getActiveTriggerDispatch();
        Test.stopTest();
        System.assert(data.size() >= 0);
    }
}