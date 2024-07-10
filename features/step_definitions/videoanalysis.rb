Given('I am filling out a new form') do
  visit '/users/sign_up'
  fill_in 'Email', with: 'users12@example.com'
  fill_in 'Password', with: 'password'
  fill_in 'Password confirmation', with: 'password'
  fill_in 'User first name', with: 'John'
  fill_in 'User last name', with: 'Doe'
  fill_in 'User contact number', with: '1234567890'
  fill_in 'User address', with: '123 Main St'
  click_button 'Sign up'
end

When('I go to the second page') do
  visit '/forms/edit_4'
end

When('I am on the second page and want to go to the video analysis page') do
 visit '/forms/edit_4'
end

And('I want to view the example video') do
  visit '/forms/edit_4'
  expect(page).to have_css('div.video-preview video', visible: true, wait: 10)  # Waits up to 10 seconds for the video to become visible
end

When('I click the play button on the example video') do
  video_xpath = "//video[source[@src='/videos/videoUploadForm1.mp4']]"
  find(:xpath, video_xpath).click
end

Then('the example video will start playing') do
  video = page.find('div.row > div:nth-child(1) .video-preview video')
  initial_time = video.evaluate_script('this.currentTime')

  sleep 1 # Wait for 3 seconds

  updated_time = video.evaluate_script('this.currentTime')
  expect(updated_time).to be > initial_time, "Video is not playing as expected."
end


Given('I am on the video analysis page') do
  visit '/users/sign_up'
  fill_in 'Email', with: 'userss@example.com'
  fill_in 'Password', with: 'password'
  fill_in 'Password confirmation', with: 'password'
  fill_in 'User first name', with: 'John'
  fill_in 'User last name', with: 'Doe'
  fill_in 'User contact number', with: '1234567890'
  fill_in 'User address', with: '123 Main St'
  click_button 'Sign up'
  fill_in 'Email', with: 'userss@example.com'
  fill_in 'Password', with: 'password'
  click_button 'Log in'
  visit '/forms/edit_4'
end

And('I upload a video') do
  expect(page).to have_css('#videoUploadForm1', visible: true, wait: 50)
  file_input = page.find('#videoInput1', visible: true, wait: 40)
  attach_file(file_input, 'C:/Users/charm/Downloads/PDS Video.mp4')
  click_button 'Upload Physical Video'
  expect(page).to have_css('div.video-preview video', visible: true, wait: 30) # Checks if the video is loaded
end

When('I click the play button on the uploaded video') do
  video = page.find('div.row > div:nth-child(1) .video-preview video')
  video.click
end

Then('the uploaded video will start playing') do
  video = page.find('div.row > div:nth-child(1) .video-preview video')
  initial_time = video.evaluate_script('this.currentTime')

  sleep 3 # Wait to ensure video plays

  updated_time = video.evaluate_script('this.currentTime')
  expect(updated_time).to be > initial_time, "Video is not playing as expected."
end
