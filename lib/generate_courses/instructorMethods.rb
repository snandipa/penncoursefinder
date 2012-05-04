require 'net/http'
require 'uri'
require 'open-uri'
require 'json'

def createSimpleInstructorHash

results = []
File.new("instructors.txt", "r").each { |line| results << line }

rawData = JSON.parse(results[0]) 
instructorArray = rawData["result"]["values"]

instructorHash = Hash.new

	for i in 0..(instructorArray.length-1)
	
	currentLastName = instructorArray[i]["last_name"]
	currentFirstName = instructorArray[i]["first_name"]
	
		if ! instructorHash.has_key?(currentLastName)
		instructorHash[currentLastName] = [[currentFirstName, instructorArray[i]["id"].split('-').first]]
		else	
		instructorHash[currentLastName] = instructorHash[currentLastName] << [currentFirstName, instructorArray[i]["id"].split('-').first]		
		end

	end
	
	return instructorHash
	
end

def getInstructorReviews instructorID

uri = URI.parse('http://pennapps.com/courses//instructors/' + instructorID.to_s() +'/reviews/?token=9YqT2mxApnVMFlcvxb2w')
instructorJSON = Net::HTTP.get(uri)
instructorHash = JSON.parse(instructorJSON)
instructorArray = instructorHash['result']['values']

return instructorArray

end

def getID(instructorLastName, instructorFirstName, instructorHash)

	if instructorHash.has_key?(instructorLastName) == false
		return -1
	else
		return getSpecficID(instructorLastName, instructorFirstName, instructorHash[instructorLastName])
	end

end

def getSpecficID(lastName, firstName, relevantIDArray)

	numRatings = relevantIDArray.length

	for i in 0..(numRatings-1)
	
	if (relevantIDArray[i][0][0] == firstName[0])
		return relevantIDArray[i][1]
	end
	
	end
	
return -1

end

def getRatings(instructorLastName, instructorFirstName, instructorHash) 

instructorID = getID(instructorLastName, instructorFirstName, instructorHash)

if instructorID == -1
return [2.5,2.5,2.5]
end

currentInstructorReviews = getInstructorReviews(instructorID)

		currentInstructorRating = 0
		currentCourseRating = 0
		currentDifficultyRating = 0
		count = 0

	for j in 0..(currentInstructorReviews.length-1)
	
		if currentInstructorReviews[j]['instructor']['last_name'] == instructorLastName			
		
		currentInstructorRating = (currentInstructorRating*count + currentInstructorReviews[j]['ratings']['rInstructorQuality'].to_f())/(count+1)
		currentCourseRating = (currentCourseRating*count + currentInstructorReviews[j]['ratings']['rCourseQuality'].to_f())/(count+1)
		currentDifficultyRating = (currentDifficultyRating*count + currentInstructorReviews[j]['ratings']['rDifficulty'].to_f())/(count+1)

		count = count + 1			
		
		end

	end
	
return [currentInstructorRating.round(2), currentCourseRating.round(2), currentDifficultyRating.round(2)]


end