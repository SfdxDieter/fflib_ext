/**
 * TriggerDispatchSelector
 */

global with sharing class TriggerDispatchSelector extends fflib_SObjectSelector{

    /**
    * Constructs the Selector
    *
    **/
    global TriggerDispatchSelector()
    {
        super(true, false, false);
    }

    /**
     * alternative result of methode
     */
    global static List<TriggerDispatch__mdt> OverwriteActiveTriggerDispatch { get; set;}

    public override List<SObjectField> getSObjectFieldList() {
        return new SObjectField[] {
                TriggerDispatch__mdt.Id,
                TriggerDispatch__mdt.Active__c,
                TriggerDispatch__mdt.ApexClass__c,
                TriggerDispatch__mdt.SObjectName__c,
                TriggerDispatch__mdt.Order__c
        };
    }


    public override SObjectType getSObjectType() {
        return TriggerDispatch__mdt.SObjectType;
    }

    global List<TriggerDispatch__mdt> getActiveTriggerDispatch() {
        this.ignoreCRUD();
        if (OverwriteActiveTriggerDispatch == null) {
            fflib_QueryFactory newquery = this.newQueryFactory();
            newquery.setCondition('Active__c = true ');
            newquery.getOrderings().clear();
            newquery.addOrdering('Order__c', fflib_QueryFactory.SortOrder.ASCENDING, false);
            return (List<TriggerDispatch__mdt>) Database.query(newquery.toSOQL());
        } else {
            return OverwriteActiveTriggerDispatch;
        }
    }
}