---
layout: post
title: "nested object forms with checkbox"
description: ""
categories: Rails
tags: []
---
versions: rails 3.2.8, ruby 1.9.4

Rails is an awesome framework.<br>
You can really concentrate on what you want you make, not how to make it.<br>
One good example is nested object forms.<br>
You dont have to write tons of code in your controller to operate models which has relations like `has_many`.

There's an good tutorial in railscast.com, [#196 Nested Model Form Part 1](http://railscasts.com/episodes/196-nested-model-form-part-1) and [#197 Nested Model Form Part 2](http://railscasts.com/episodes/197-nested-model-form-part-2), so I'm not gonna explain about nested object forms.


I wanted to create an nested object forms using checkboxes just like the below image.

![check_boxes](/assets/image/nested-object-forms-with-checkboxes/checkboxes.png)


This needs a little twist, if you understand the nested object forms you'll know why.

I'll show you how I did this, if there's any better way to do this, please comment :)

Lets say we have article table and category table, And we want to register multiply category on 1 article by using checkboxes.


# The basics(models)

the models will be like the below

{% highlight ruby %}
class Article < ActiveRecord::Base
  attr_accessible :articles_categories_attributes

  has_many :categories, :through => :articles_categories
  has_many :articles_categories, :dependent => :destroy

  accepts_nested_attributes_for :articles_categories, :allow_destroy => true
end
{% endhighlight %}

{% highlight ruby %}
class ArticlesCategory < ActiveRecord::Base
  attr_accessible :article_id, :category_id

  belongs_to :article
  belongs_to :category
end
{% endhighlight %}

{% highlight ruby %}
class Category < ActiveRecord::Base
  attr_accessible :name

  has_many :articles, :through => :articles_categories
  has_many :articles_categories, :dependent => :destroy
end
{% endhighlight %}


# form and update method

this is the part which is different from normal nested object forms

**view**

{% highlight ruby %}
<% Category.all.each do |category| %>

  <% check_flag = @article.articles_categories.any? { |articles_category| articles_category.category_id == category.id } %>

  <%= check_box_tag "article[articles_categories_attributes][][category_id]", category.id, check_flag %>
  <%= category.name %>
<% end %>
{% endhighlight %}

basically you can't use fields_for, so you have to write it like this.


**update method**

{% highlight ruby %}
def update
  ArticlesCategory.transaction do
    @article = Article.find(params[:id], :lock => true)
    @article.articles_categories.clear
    @article.update_attributes!(params[:interview_article])
  end
    flash[:notice] = 'Article was successfully updated.'
    redirect_to :action => 'index'
  rescue ActiveRecord::RecordInvalid
    render :action => 'edit'
end
{% endhighlight %}

If we don't do this, the checkbox which has been turned off wont be deleted properly.

That's it! feel free to comment.
