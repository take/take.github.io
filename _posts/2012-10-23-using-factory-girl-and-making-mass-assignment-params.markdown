---
layout: post
title: "Using factory girl and making mass assignment params"
date: 2012-10-23 13:19
comments: true
categories: Rails
---

versions: factory_girl_rails: 4.1.0, rails: 3.2.8, rspec: 2.11.0


Writing controllers examples are pretty tough.
For example, when you have to write some update method examples, 

1. first we gotta save a data to the DB which we are going to update, 
2. and prepare params(which is based on the data which we saved in 1.) to send to the update method, 
3. and finnaly, execute the update method.

and when it goes with the nested object forms, it gets tougher.

I'll show you how I did it, its kinda messed up, so if you have some better solution, please comment.

## FactoryGirl Data(preparation)

first we need to get FactoryGirl ready, so we can get some test data and use those.

lets say we have an Article table and a ArticleBody table, the relations will be like bellow.
It'll be basic nested objects using `nested_attributes_for` and `has_many`.
If you don't understand those, there's some good tutorial on rails cast which I mentioned [here](/nested-object-forms-with-checkboxes/), so look at that.

{% highlight ruby %}
class Article < ActiveRecord::Base
  attr_accessible :title

  has_many :article_bodies, :dependent => :delete_all
  accepts_nested_attributes_for :article_bodies, :allow_destroy => true
end
{% endhighlight %}

{% highlight ruby %}
class ArticleBody < ActiveRecord::Base
  attr_accessible :subtitle, :body
  
  belongs_to :article
end
{% endhighlight %}

the factory girl data will be like bellow

{% highlight ruby %}
FactoryGirl.define do
  factory :article, :class => 'Article' do
    title "test article title"

    factory :article_with_bodies, :class => 'Article' do
      ignore do
        body_count 3
      end

      after(:create) do |article, evaluator|
        FactoryGirl.create_list(:article_body, evaluator.body_count, article: article)
      end
    end
  end

  factory :article_body, :class => 'ArticleBody' do
    article
    sequence(:subtitle) { |n| "subtitle #{n}"}
    sequence(:body) { |n| "body #{n}"}
  end
end
{% endhighlight %}

I basically read the [GETTING_STARTED.md](https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md#associations) which was in the factory girl repo to get the factory.rb done.


## getting shits done :p

now lets look back what we have to do which I mentioned earlier.

1. first we gotta save a data to the DB which we are going to update, 
2. and prepare params(which is based on the data which we saved in 1.) to send to the update method, 
3. and finnaly, execute the update method.


### 1. first we gotta save a data to the DB which we are going to update,

this is basic, just like bellow.

{% highlight ruby %}
@article = FactoryGirl.create(:article_with_bodies)
{% endhighlight %}


### 2. and prepare params(which is based on the data which we saved in 1.) to send to the update method, 

this is going to be the tricky part, I did it like this.

{% highlight ruby %}
params = @article.attributes.except('created_at', 'updated_at')
params['article_bodies_attributes'] = []
@article.article_bodies.count.times do |i|
  params['article_bodies_attributes'] << @article.article_bodies[i].attributes.except('created_at', 'updated_at')
end
{% endhighlight %}

If you want to change the values inside the article_bodies, you can do it by writing like this.

`params['article_bodies_attributes'][0]['subtitle'] = 'bar'`

### 3. and finnaly, execute the update method.

{% highlight ruby %}
put :update, {:id => @article.id, :article => params }
{% endhighlight %}

thats it!

feel free to comment :)
