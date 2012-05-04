require_relative 'courseImport'
require_relative 'instructorMethods'

startCourseID = 32485
endCourseID =  34598 

def main(startCourseID, endCourseID)

puts 'Downloading course data...'
startTime = Time.now

instructorHash = createSimpleInstructorHash

f = File.new("commands.txt", "w")
count = 0

coursesToAdd = []

	for i in startCourseID..endCourseID
		begin
			sectionArray = getCourse i
			current = createDataBaseCommands(sectionArray , instructorHash)

				if current != nil
				f.write(current[0])
				count = count + 1
				coursesToAdd << current[1]
				end
		rescue
			next
		end
	end

finalCommand = "\n\n" + 'desc "Run all bootstrapping tasks"' + "\n" + 'task :all => ['

	for i in 0..(coursesToAdd.length-2)
		finalCommand = finalCommand + coursesToAdd[i] + ', '
	end

finalCommand = finalCommand + coursesToAdd[coursesToAdd.length-1] + ']'

f.write(finalCommand)
	
endTime = Time.now

runtime = (endTime - startTime)/60
runtimePerQuery = runtime*60/(endCourseID - startCourseID)

puts "\n"
puts "Commands generated for a total of " + count.to_s() + " classes"
puts "\n"
puts "Runtime was " + runtime.round(3).to_s() + " minutes"
puts "Runtime per query was " + runtimePerQuery.round(3).to_s() + " seconds"
puts "\n"
f.close

end


main(startCourseID, endCourseID)