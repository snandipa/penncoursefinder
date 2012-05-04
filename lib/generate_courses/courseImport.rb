# http://pennapps.com/courses//courses/32979/sections?token=9YqT2mxApnVMFlcvxb2w

require 'net/http'
require 'uri'
require 'open-uri'
require 'json'

require_relative 'instructorMethods'


def getCourse courseID

uri = URI.parse('http://pennapps.com/courses//courses/' + courseID.to_s() +'/sections?token=9YqT2mxApnVMFlcvxb2w')
courseJSON = Net::HTTP.get(uri)
courseHash = JSON.parse(courseJSON)
sectionArray = courseHash['result']['values']

return sectionArray

end
	
def createLecCommands(sectionInfo, courseCUSIP, numLec, instructorLastName, instructorFirstName, instructorHash)

lectureRatings =  getRatings(instructorLastName, instructorFirstName, instructorHash) 

instructorRating = lectureRatings[0]
courseRating = lectureRatings[1]
courseDifficutly = lectureRatings[2]

thisSectionsCommands = 's' + numLec.to_s() + ' = Section.create(' +
						'listing:' + sectionInfo['aliases'][0].split('-').last.to_i.to_s +
						', course_id:Course.find_by_cusip(' + courseCUSIP +
						').id, instructor: "' + sectionInfo['instructors'][0]['name'] +
						'", instructor_rating: ' +	instructorRating.to_s()	 + ')' + 
						"\n"
						
addMeetingsCommand = 's' + numLec.to_s() + '.meetings'

	for i in 0..(sectionInfo['meetingtimes'].length-1)

	thisSectionsCommands = thisSectionsCommands + 't' + (i+1).to_s() + 
						   ' = Meeting.create(start_time:' + formatTime(sectionInfo['meetingtimes'][i]['start']) +
						   ', end_time:' + formatTime(sectionInfo['meetingtimes'][i]['end']) +
						   ', day:' +	getDayNum(sectionInfo['meetingtimes'][i]['day'])	+ ')' + "\n" 

	addMeetingsCommand = addMeetingsCommand + ' << ' + 't' + (i+1).to_s()
						   
	end


finalCommand = thisSectionsCommands + addMeetingsCommand + "\n"	
lectureInfo = [finalCommand, courseRating, courseDifficutly]
	
return lectureInfo 

end

def createRecCommands(sectionInfo, courseCUSIP, numRec)

thisSectionsCommands = 'r' + numRec.to_s() + ' = Recitation.create(' +
						'listing:' + sectionInfo['aliases'][0].split('-').last.to_i.to_s +
						', course_id:Course.find_by_cusip(' + courseCUSIP + '))' +
						"\n"
						
addMeetingsCommand = 'r' + numRec.to_s() + '.meetings'

	for i in 0..(sectionInfo['meetingtimes'].length-1)

	thisSectionsCommands = thisSectionsCommands + 't' + (i+1).to_s() + 
						   ' = Meeting.create(start_time:' + formatTime(sectionInfo['meetingtimes'][i]['start']) +
						   ', end_time:' + formatTime(sectionInfo['meetingtimes'][i]['end']) +
						   ', day:' +	getDayNum(sectionInfo['meetingtimes'][i]['day'])	+ ')' + "\n" 

	addMeetingsCommand = addMeetingsCommand + ' << ' + 't' + (i+1).to_s()
						   
	end


return thisSectionsCommands + addMeetingsCommand + "\n"

end


def formatTime badTime

goodTime = badTime.to_f() / 100

if goodTime.to_i() != goodTime
goodTime = goodTime + 0.2
end

return goodTime.to_s()

end

def getDayNum day

if day == "M"
return '1'
elsif day == "T"
return '2'
elsif day == "W"
return '3'
elsif day == "R"
return '4'
else 
return '5'

end

end

def getCategory(dept)


if dept == "ECON" || dept == "PSCI" || dept == "PSYC"
return 'SS'
elsif dept == "ANTH" || dept == "ENGL" || dept == "SAST"
return 'H'
elsif dept == "BIOL" || dept == "CHEM" || dept == "PHYS"
return 'NS'
elsif dept == "MATH"
return 'M'
elsif dept == "CIS" || dept == "ESE" || dept == "MEAM" || dept == "MSE"
  return 'E'
else
return 'N'
end


end

def createDataBaseCommands(sectionArray, instructorHash)

numSections = sectionArray.length

	if numSections == 0
	return
	end

	if sectionArray[0]['courses']['semester'] != '2011C'
	return
	end
	
	numLec = 0
	numRec = 0
	
	department = sectionArray[0]['courses']['aliases'][0].split('-').first
	department = department.strip #remove all leading and trailing whitespace
	courseNumber = sectionArray[0]['courses']['aliases'][0].split('-').last.to_i.to_s
	courseName = sectionArray[0]['courses']['name']
	courseCUSIP = sectionArray[0]['courses']['path'].split('/').last
	courseCategory = getCategory(department)
	
	courseRating = 0
	courseDifficutly = 0
	
	databaseCommands = ""					
	# puts "Number of sections " + numSections.to_s() + "\n"
	
	
	for i in 0..(numSections-1)

		thisSectionsCommands = ''
		
		if sectionArray[i]['meetingtimes'].length != 0 && sectionArray[i]['instructors'].length != 0 && (sectionArray[i]['meetingtimes'][0]['type'] == "LEC" || sectionArray[i]['meetingtimes'][0]['type'] == "SEM")
		
			numLec = numLec + 1
			
			instructorLastName = sectionArray[i]['instructors'][0]['last_name']
			instructorFirstName = sectionArray[i]['instructors'][0]['first_name']
			
			thisLecture = createLecCommands(sectionArray[i], courseCUSIP, numLec, instructorLastName, instructorFirstName, instructorHash)
			

			courseRating = (courseRating*(numLec-1) + thisLecture[1])/numLec
			courseDifficutly = (courseDifficutly*(numLec-1) + thisLecture[2])/numLec
			
			thisSectionsCommands = thisLecture[0]
		
		end
		
		if sectionArray[i]['meetingtimes'].length != 0 && sectionArray[i]['instructors'].length != 0 && sectionArray[i]['meetingtimes'][0]['type'] == "REC"
		
			numRec = numRec  + 1
			thisSectionsCommands = createRecCommands(sectionArray[i], courseCUSIP, numRec)
		
		end
		
		databaseCommands = databaseCommands + thisSectionsCommands + "\n"

	end
	
	if numLec == 0
	return
	end
	
	if (courseDifficutly == 0)
	courseDifficutly = 2.5
	end
	
	# addSections
	if(numLec > 0)
	addSecCommand = 'c.sections' 
	for i in 1..numLec
	addSecCommand = addSecCommand + ' << s' + i.to_s()
	end
	
	databaseCommands = databaseCommands + "\n" + addSecCommand + "\n"
	end
	
	# addRecitations
	if(numRec > 0)
	addRecCommand = 'c.recitations' 
	for i in 1..numRec
	addRecCommand = addRecCommand + ' << r' + i.to_s()
	end

	databaseCommands = databaseCommands + "\n" + addRecCommand + "\n\n"
	end
	
	unless courseCategory == 'N'
            databaseCommands = databaseCommands + 'r = Requirement.find_by_category("' + courseCategory + '")' + "\n"
            databaseCommands = databaseCommands + 'r.courses << c' + "\n" 'r.save' + "\n\n"
	end
	
	#Add Header
	header = "\n\n\n"
	header = header + 'task :add' + department + courseNumber + ' => :environment do' + "\n\n" +
						'c= Course.create(:department => "' + department + 
						'", :number => '  + courseNumber + 
						', :name => "' +  courseName   + 
						'", :cusip => ' + courseCUSIP +
						', :cus => ' +   '1.0'    +
						', :course_rating => ' +	courseRating.to_s() 	+
						', :difficulty_rating => ' +	courseDifficutly.to_s()	+ ')' +
						"\n\n"

	
	databaseCommands = header + databaseCommands + 'end' + "\n"
	addKey = ':add' + department + courseNumber
	
	return [databaseCommands, addKey]
	end
	


