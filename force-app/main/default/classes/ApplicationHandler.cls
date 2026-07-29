public class ApplicationHandler {
    public static void calculateScore(List<Application__c> applications) {
        Set<Id> candidateIds = new Set<Id>();
        Set<Id> jobIds = new Set<Id>();
        for(Application__c app : applications){
            if(app.Candidate__c != null){
                candidateIds.add(app.Candidate__c);
            }
            if(app.Job__c != null){
                jobIds.add(app.Job__c);
            }
        }
        Map<Id, Candidate__c> candidateMap = new Map<Id, Candidate__c>([ SELECT Id, Experience__c, Skills__c FROM Candidate__c WHERE Id IN :candidateIds ]);
        Map<Id, Job__c> jobMap = new Map<Id, Job__c>([ SELECT Id, Experience__c, Skills__c FROM Job__c WHERE Id IN :jobIds ]);
        for(Application__c app : applications){
            Integer totalScore = 0;
            Candidate__c candidate = candidateMap.get(app.Candidate__c);
            Job__c job = jobMap.get(app.Job__c);
            if(candidate != null && job != null){
                totalScore += calculateSkillScore(candidate.Skills__c, job.Skills__c);
                totalScore += calculateExperienceScore(candidate.Experience__c, job.Experience__c);
            }
            app.Score__c = totalScore;
        }
    }

    private static Integer calculateSkillScore(
        String candidateSkills,
        String jobSkills
    ){
        if(String.isBlank(candidateSkills) ||
           String.isBlank(jobSkills)){
            return 0;
        }
        Set<String> candidateSkillSet = new Set<String>( candidateSkills.split(';') );
        List<String> requiredSkills = jobSkills.split(';');
        Integer matchedSkills = 0;
        for(String skill : requiredSkills){
            if(candidateSkillSet.contains(skill)){
                matchedSkills++;
            }
        }
        Integer score =
            (matchedSkills * 50) /
            requiredSkills.size();
        return score;
    }
    private static Integer calculateExperienceScore(
        String candidateExperience,
        String jobExperience
    ){
        Integer candidateExp = convertExperience(candidateExperience);
        Integer jobExp = convertExperience(jobExperience);
        if(candidateExp >= jobExp){
            return 50;
        }
        else if(candidateExp > 0){
            return 25;
        }
        else{
            return 10;
        }
    }
    private static Integer convertExperience(String experience){
        if(String.isBlank(experience)){
            return 0;
        }
        return Integer.valueOf(experience);
    }

    public static void updateStatus(List<Application__c> applications){
        for(Application__c app : applications){
            if(app.Status__c == 'Selected' ||
               app.Status__c == 'Rejected' ||
               app.Score__c == null){
                continue;
            }
            if(app.Score__c < 75){
                app.Status__c = 'Rejected';
            }
            else if(app.Score__c >= 80){
                app.Status__c = 'Shortlisted';
            }
            else{
                app.Status__c = 'Applied';
            }
        }
    }

}