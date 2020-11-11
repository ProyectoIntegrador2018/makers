def sign_in_as(user)
  login_as(user, scope: :user, run_callbacks: false)
end

def sign_up(email: 'hola@itesm.mx', password: 'foobar123', password_confirmation: 'foobar123')
  visit new_user_registration_path
  fill_in 'user_given_name', with: Faker::Name.name
  fill_in 'user_last_name', with: Faker::Name.name
  fill_in 'user_institutional_id', with: 'A01234567'
  fill_in "user_email", with: email
  fill_in "user_password", with: password
  fill_in 'user_password_confirmation', with: password_confirmation
  click_button 'Enviar'
end

def emails
  ActionMailer::Base.deliveries
end

def last_email
  emails.last
end

def first_reservation
  Reservation.first
end

def reload_page
  visit current_path
end

def calendar_select(start_time, end_time)
  page.execute_script("calendar_select('#{start_time.iso8601}', '#{end_time.iso8601}')")
end

def readable_date_range(start_time, end_time)
  s = readable_date(start_time) + ' -'
  s.concat end_time.utc.strftime(' %a %b %e %Y') if start_time.to_date != end_time.to_date
  s + end_time.utc.strftime(' %k:%M')
end

def readable_date(time)
  time.utc.strftime('%a %b %e %Y %k:%M')
end

def tomorrow
  Time.current.utc + 1.day
end

# To ensure reservation is in the future, otherwise :date_range_valid fails
def future_monday
  now = Time.current + 7.day
  to_add = (1 - now.wday + 7) % 7
  now + to_add.day
end
