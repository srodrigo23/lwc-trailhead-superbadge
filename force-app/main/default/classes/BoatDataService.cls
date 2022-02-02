public with sharing class BoatDataService {

    public BoatDataService() {

    }

    @AuraEnabled(cacheable=true)
    public static List<BoatType__c> getBoatTypes(){
        return [SELECT Name, Id FROM BoatType__c WITH SECURITY_ENFORCED ORDER BY Name];
    }

    @AuraEnabled(cacheable=true)
    public static List<Boat__c> getBoats(String boatTypeId){
        String query = 'SELECT Name, Description__c, Picture__c, Contact__r.Name, BoatType__c, BoatType__r.Name, Length__c, Price__c ' + 
                        'From Boat__c ';
        if(String.isNotEmpty(boatTypeId)){
            query = query + 'WHERE BoatType__c =: boatTypeId';
        }
        return Database.query(query);
    }

    @AuraEnabled(cacheable=true)
    public static List<Boat__c> getSimilarBoats(Id boatId, String similarBy){
        return new List<Boat__c>();
    }

    @AuraEnabled
    public static List<BoatReview__c> getAllReviews(Id boatId){
        return new List<BoatReview__c>();
    }

    @AuraEnabled(cacheable=true)
    public static String getBoatsByLocation(Decimal latitude, Decimal longitude, String boatTypeId){
        String query = 'SELECT Name, Geolocation__Latitude__s, Geolication__Longitude__s FROM Boat__c ';
        if(String.isNotEmpty(boatTypeId)){
            query = query + 'WHERE BoatType__c =: boatTypeId ';
        }
        query += 'WITH SECURITY_ENFORCED ORDER BY DISTANCE(Geolocation__c, GEOLOCATION(:latitude, :longitude), \'mi\') LIMIT 10';
        return JSON.serialize(Database.query(query));
    }

    @AuraEnabled
    public static String updateBoatList(Object data){
        List<Boat__c> boatsForUpdate = (List<Boat__c>)JSON.deserialize(JSON.serialize(data), List<Boat__c>.class);
        update boatsForUpdate;
        return 'Success: Boats updated successfully';
    }
}