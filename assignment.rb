module Questions
    class QuestionClass
        attr_accessor :question, :ans
        def self.create
            instance=QuestionClass.new
        end
        def ask(qu)
            @question=qu
            print "#{@question}"
            @ans=gets.chomp
            self
        end
        def show
            puts "#{@question} your answer: #{@ans}"            
        end
    end
end
class Participant
    attr_accessor :age, :name, :gender
    def initialize 
        print "Enter your full name: "
        @name=gets.chomp
        print "Enter your age: "
        @age=gets.chomp.to_i
        print "Enter your gender: "
        @gender=gets.chomp
        self
    end
end
module Study
    class StudyClass
        def self.create study_name
            @study_name=study_name
            instance=StudyClass.new    
        end
        def validate(questionArray,participant)
            age=participant.age
            yesans=0
            questionArray.each do|q|
                if q.ans=="yes"
                    yesans +=1
                end
            end
            if age>18 && yesans>2
                puts "Congratulations #{ participant.name } you are eligible for the clinical trial !!!"
                true
            else
                puts "We regret to inform you that you are not eligible for this clinical trial."
                false
            end

        end
    end
end
class StudyConduct
    include Study
    include Questions
    def initialize study_name
        @study_name=study_name
        @study=Study::StudyClass.create(@study_name)
    end
     def study_conduct
        puts "Welcome to #{ @study_name } !"
        @participant=Participant.new
        @questionsArr=[]
        @questionsArr.push(Questions::QuestionClass.create.ask("Have you read all terms and conditions ? "))
        @questionsArr.push(Questions::QuestionClass.create.ask("Are you ok if we store your information for study purpose? "))
        @questionsArr.push(Questions::QuestionClass.create.ask("Are you aware of the purpose of the study Conduct ? "))
        @questionsArr.push(Questions::QuestionClass.create.ask("Are your ready for the Clinical Trial? "))
        @study.validate(@questionsArr,@participant)
        puts "Below is your captured details"
        puts "Name : #{@participant.name}"
        puts "Age : #{@participant.age}"
        puts "Gender : #{@participant.gender}"
        @questionsArr.each{|q| q.show}
      end
end

studyConductObj=StudyConduct.new("Covid-19")
studyConductObj.study_conduct
