class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end
  
  def create

    actor = Actor.new

    actor.name = params.fetch("the_name")
    actor.dob = params.fetch("the_dob")
    actor.bio = params.fetch("the_bio")
    actor.image = params.fetch("the_image")

    actor.save

    redirect_to("/actors")
  end

  def destroy
    the_id = params.fetch("an_id")
    matching_actors = Actor.where({ :id => the_id})
    the_actor = matching_actors.at(0)

    the_actor.destroy

    the_actor.save

    redirect_to("/actors")
  end

  def update
    actor_id = params.fetch("the_id")

    matching_actors = Actor.where({ :id => actor_id})
    the_actor = matching_actors.at(0)

    the_actor.name = params.fetch("the_name")
    the_actor.dob = params.fetch("the_dob")
    the_actor.bio = params.fetch("the_bio")
    the_actor.image = params.fetch("the_image")

    the_actor.save

    redirect_to("/actors/#{the_actor.id}")
  end


end
