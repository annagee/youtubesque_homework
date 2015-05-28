require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require 'pry-byebug'

get '/'  do

  redirect to ('/home')

end  

get '/home' do
  sql = 'select * from videos'
  @video = run_sql(sql)
  erb :home
  
end

get '/home/new' do

  erb :new

end


post '/home' do
  sql = "insert into videos(title, description, url, genre) values ('#{params[:title]}', '#{params[:description]}', '#{params[:url]}', '#{params[:genre]}')"

  @video = run_sql(sql)
  # redirect to('/home')
  erb :home
end


get '/home/:id' do
  sql = "select * from  videos where id = #{params[:id]}"
   @video = run_sql(sql)
   erb :show
end

get '/show' do

  erb :show
end

get '/home/:id/edit' do
  sql = "select * from  videos where id = #{params[:id]}"
  @video = run_sql(sql)
  erb :show
 end 


post '/home/:id' do
  sql ="update videos set url = '#{params[:title]}', description = '#{params[:description]}', '#{params[:url]}', '#{params[:genre]}' where id = #{params[:id]}"
  run_sql(sql) 
  redirect to ("/home/#{params[:id]}")
end


delete '/home/:id/delete' do
   sql = "delete from videos where id = #{params[:id]}"
   run_sql(sql)
   redirect to ('/home')
end


private
def run_sql(sql)
  conn = PG.connect(dbname: 'videodb', host: 'localhost')
  begin
    result = conn.exec(sql)
  
  ensure
    conn.close
  end  
     result
  end   