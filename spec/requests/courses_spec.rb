require 'rails_helper'

RSpec.describe 'Courses and Tutors API', type: :request do
  describe 'Create course and its Tutors' do
    context 'when valid attributes are provided' do
      let(:valid_attributes) { 
        { course: 
          { title: Faker::Lorem.word,
            tutors_attributes: [
              {
                name: Faker::Name.name
              },
              {
                name: Faker::Name.name
              }
            ]
          } 
        }
      }

      before { post '/api/v1/courses', params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns course and its tutors' do
        expect(json).not_to be_empty
      end

      it 'creates one course and two tutors' do
        course = Course.all
        expect(course.count).to eq(1)
        expect(course.first.tutors.count).to eq(2)
      end
    end

    context 'when course title is nil' do
      let(:invalid_attributes) { 
        { course: 
          { title: nil
          } 
        } 
      }

      before { post '/api/v1/courses', params: invalid_attributes }

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end

      it 'returns title cant be blank' do
        expect(json["title"].first).to match(/can't be blank/)
      end
    end

    context 'when duplicate course title is provided' do
      let!(:course) { create(:course) }
      let(:invalid_attributes) { 
        { course: 
          { title: course.title
          } 
        } 
      }

      before { post '/api/v1/courses', params: invalid_attributes }

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end

      it 'returns title has already been taken' do
        expect(json["title"].first).to match(/has already been taken/)
      end
    end

    context 'rejects with tutors name is blank' do
      let(:invalid_attributes) { 
        { course: 
          { title: Faker::Lorem.word,
            tutors_attributes: [
              {
                name: Faker::Name.name
              },
              {
                name: nil
              }
            ]
          } 
        }
      }

      before { post '/api/v1/courses', params: invalid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'ignores the second tutor' do
        expect(Course.first.tutors.count).to eq(1)
      end
    end
  end

  describe 'Get Course and its Tutors' do
    let!(:course) { create(:course) }
    let!(:tutors) { create_list(:tutor, 10, course: course) }

    before { get '/api/v1/courses' }

    it 'returns course and its tutors' do
      expect(json).not_to be_empty
      expect(json['included'].size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end 