class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end

  def create
    director = Director.new

    director.name = params.fetch("the_name")
    director.dob = params.fetch("the_dob")
    director.bio = params.fetch("the_bio")
    director.image = params.fetch("the_image")

    director.save

    redirect_to("/directors")
  end

  def destroy
  
  the_id = params.fetch("an_id")
  matching_directors = Director.where({ :id => the_id})
  the_director = matching_directors.at(0)

  the_director.destroy
  
  the_director.save

  redirect_to("/directors")
  end


  def update
    director_id = params.fetch("the_id")

    matching_actors = Director.where({ :id => director_id})
    the_director = matching_actors.at(0)

    the_director.name = params.fetch("the_name")
    the_director.dob = params.fetch("the_dob")
    the_director.bio = params.fetch("the_bio")
    the_director.image = params.fetch("the_image")

    the_director.save

    redirect_to("/directors/#{the_director.id}")
  end

end
