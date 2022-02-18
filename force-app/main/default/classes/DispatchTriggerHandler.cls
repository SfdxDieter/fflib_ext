/**
 * DispatchTriggerHandler based on fflib
 */

/**
 * DispatchTriggerHandler
 */
global with sharing class DispatchTriggerHandler {

    private static Map<String,List<String>> triggerHandler = null;

    /**
     * load trigger match and keep it
     */
    private static void init() {
        if (triggerHandler == null) {
            triggerHandler = new Map<String,List<String>>();
            List<TriggerDispatch__mdt> handlers = new TriggerDispatchSelector().getActiveTriggerDispatch();
            for (TriggerDispatch__mdt handler : handlers) {
                String objectName = handler.SObjectName__c.toLowerCase();
                if (triggerHandler.containsKey(objectName)) {
                    triggerHandler.get(objectName).add(handler.ApexClass__c);
                } else {
                    triggerHandler.put(objectName, new List<String> {handler.ApexClass__c});
                }
            }
        }
    }

    /**
     * DispatchTriggerHandler uses
     * @param domainClass sobject to use
     */
    global static void triggerHandler(Type domainClass)
    {
        init();
        String typeName = domainClass.getName().toLowerCase();
        if (triggerHandler.containsKey(typeName)) {
            for (String className : triggerHandler.get(typeName)) {
                    Type t = Type.forName(className);
                    if (t != null) {
                        System.debug(LoggingLevel.DEBUG, 'Found trigger ' + className);
                        fflib_SObjectDomain.triggerHandler(t);
                    } else {
                        System.debug(LoggingLevel.DEBUG, 'Did not found trigger ' + className);
                    }
            }
        }
    }

    /**
     * disable
     * @param domainClass class Type
     */
    global static void disableAllTriggerEvents(Type domainClass) {
        do4AllClassTriggerEvents(domainClass, false);
    }

    /**
     * enable
     * @param domainClass class Type
     */
    global static void enableAllTriggerEvents(Type domainClass) {
        do4AllClassTriggerEvents(domainClass, true);
    }


    private static void do4AllClassTriggerEvents(Type domainClass, Boolean enableTrigger) {
        init();
        String typeName = domainClass.getName().toLowerCase();
        if (triggerHandler.containsKey(typeName)) {
            for (String className : triggerHandler.get(typeName)) {
                Type t = Type.forName(className);
                if (t != null) {
                    if (enableTrigger) {
                        System.debug(LoggingLevel.DEBUG, 'Found trigger ' + className + ' to enable');
                        fflib_SObjectDomain.getTriggerEvent(t).enableAll();
                    } else {
                        System.debug(LoggingLevel.DEBUG, 'Found trigger ' + className + ' to disable');
                        fflib_SObjectDomain.getTriggerEvent(t).disableAll();
                    }

                } else {
                    System.debug(LoggingLevel.DEBUG, 'Did not found trigger ' + className);
                }
            }
        }
    }

    /**
     * disable all TriggerEvents
     */
    global static void disableAllTriggerEvents() {
        doAllTriggerEvents(false);
    }

    /**
     * enable all TriggerEvents
     */
    global static void enableAllTriggerEvents() {
        doAllTriggerEvents(true);
    }


    private static void doAllTriggerEvents(Boolean enableTrigger) {
        init();
        for (String key : triggerHandler.keySet()) {
            System.debug(LoggingLevel.DEBUG, 'Found trigger ' + key);
            for (String className : triggerHandler.get(key)) {
                Type t = Type.forName(className);
                if (t != null) {
                    if (enableTrigger) {
                        System.debug(LoggingLevel.DEBUG, 'Found trigger ' + className + ' to enable');
                        fflib_SObjectDomain.getTriggerEvent(t).enableAll();
                    } else {
                        System.debug(LoggingLevel.DEBUG, 'Found trigger ' + className + ' to disable');
                        fflib_SObjectDomain.getTriggerEvent(t).disableAll();
                    }
                } else {
                    System.debug(LoggingLevel.DEBUG, 'Did not found trigger ' + className);
                }
            }
        }
    }

    /**
     * getTriggerEvent
     * @param domainClass class Type
     *
     * @return list of events
     */
    global static List<fflib_SObjectDomain.TriggerEvent> getTriggerEvent(Type domainClass)
    {
        init();
        List<fflib_SObjectDomain.TriggerEvent> triggerEvents = new List<fflib_SObjectDomain.TriggerEvent>();
        String typeName = domainClass.getName().toLowerCase();
        if (triggerHandler.containsKey(typeName)) {
            for (String className : triggerHandler.get(typeName)) {
                Type t = Type.forName(className);
                if (t != null) {
                    System.debug(LoggingLevel.DEBUG, 'Found trigger ' + className);
                    triggerEvents.add(fflib_SObjectDomain.getTriggerEvent(t));
                } else {
                    System.debug(LoggingLevel.DEBUG, 'Did not found trigger ' + className);
                }
            }
        }
         return triggerEvents;
    }
}