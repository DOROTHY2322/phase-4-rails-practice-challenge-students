class StudentsController < ApplicationController
    before_action :set_instructor, only: [:index, :create]
    before_action :set_student, only: [:show, :update, :destroy]
  
    def index
      students = @instructor.students
      render json: students
    end
  
    def show
      render json: @student
    end
  
    def create
      student = @instructor.students.new(student_params)
      if student.save
        render json: student, status: :created
      else
        render json: { errors: student.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      if @student.update(student_params)
        render json: @student
      else
        render json: { errors: @student.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      @student.destroy
      head :no_content
    end
  
    private
  
    def set_instructor
      @instructor = Instructor.find(params[:instructor_id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Instructor not found' }, status: :not_found
    end
  
    def set_student
      @student = Student.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Student not found' }, status: :not_found
    end
  
    def student_params
      params.require(:student).permit(:name, :major, :age, :instructor_id)
    end
  end
  