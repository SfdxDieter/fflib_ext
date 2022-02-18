/**
 * Demo CaseTriggerHandler for tests
 */

public with sharing class DemoCaseTriggerHandler extends fflib_SObjectDomain {

    @TestVisible
    private static Boolean throwException = false;

    /**
         * Helper class to automatically create a new instance of this
         * domain class in the generic trigger handler.
         */
    public class Constructor implements fflib_SObjectDomain.IConstructable {

        /**
         * Create the domain class instance
         * @param sObjectList objects
         * @return trigger handler
         */
        public fflib_SObjectDomain construct(final List<SObject> sObjectList) {
            return new DemoCaseTriggerHandler(sObjectList);
        }

    }

    public DemoCaseTriggerHandler(final List<SObject> sObjectList) {
        super(sObjectList);
    }

    /**
    * Case Trigger before insert logic
    */
    public override void onBeforeInsert() {
        System.debug('onBeforeInsert');
        if (throwException) {
            Integer i = 1/0;
        }
    }
}