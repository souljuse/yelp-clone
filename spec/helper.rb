def sign_up(email)
  visit('/')
  click_link('Sign up')
  fill_in('Email', with: email)
  fill_in('Password', with: 'testtest')
  fill_in('Password confirmation', with: 'testtest')
  click_button('Sign up')
end

def sign_in(email)
  visit('/')
  click_link('Sign in')
  fill_in('Email', with: email)
  fill_in('Password', with: 'testtest')
  click_button('Sign in')
end

def sign_up_and_sign_in(email)
  sign_up(email)
  sign_in(email)
end
