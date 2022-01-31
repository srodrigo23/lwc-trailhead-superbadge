public with sharing class BoatDataService {

    public BoatDataService() {

    }

    @AuraEnabled(cacheable=true)
    public static List<BoatType__c> getBoatTypes(){
        return [SELECT Name, Id FROM BoatType__c WITH SECURITY_ENFORCED ORDER BY Name];
    }

    @AuraEnabled(cacheable=true)
    public static string methodName(){
        try {
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
