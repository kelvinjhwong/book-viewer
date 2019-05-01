require "sinatra"
require "sinatra/reloader" if development?
require "tilt/erubis"

def each_chapter
  @contents.each_with_index do |title, idx|
    number = idx + 1
    contents = File.read "data/chp#{number}.txt"
    yield(number, title, contents)
  end
end

def each_paragraph(chapter_contents)
  paragraphs = chapter_contents.split("\n\n")
  
  paragraphs.each_with_index do |paragraph_text, idx|
    paragraph_num = idx + 1
    yield(paragraph_text, paragraph_num)
  end
end

def chapters_matching(query)
  results = []
  
  return results if query.nil? || query.empty?
  
  each_chapter do |number, title, contents|
    result = { number: number, title: title, paragraphs: [] }
    
    each_paragraph(contents) do |paragraph_text, paragraph_num|
      if paragraph_text =~ /#{query}/i
        result[:paragraphs] << { text: paragraph_text, num: paragraph_num }
      end
    end
    
    results << result unless result[:paragraphs].empty?
  end  
  
  results
end

before do
  @contents = File.readlines 'data/toc.txt'
end

helpers do
  def in_paragraphs(text)
    text.split("\n\n").map.with_index do |paragraph, idx|
      "<p id=paragraph#{idx + 1}>" + paragraph + "</p>"
    end.join
  end
  
  def paragraph_text(chapter_num, paragraph_num)
    chapter_text = File.read "data/chp#{chapter_num}.txt"
    chapter_text.split("\n\n")[paragraph_num - 1]
  end
  
  def highlight(text, query)
    text.gsub(/(#{query})/i, '<strong>\1</strong>')
  end
end

get "/" do
  @title = 'The Adventures of Sherlock Holmes'
  
  erb(:home)
end

get "/chapters/:number" do
  number = params['number'].to_i
  redirect '/' unless (1..12).cover? number
  
  chapter_name = @contents[number - 1]
  
  @title = "Chapter #{number}: #{chapter_name}"
  @chapter = File.read("data/chp#{number}.txt")
  
  erb(:chapter)
end

get '/search' do
  @query = params['query']
  @results = chapters_matching(@query)

  erb(:search)
end

not_found do
  redirect '/'
end