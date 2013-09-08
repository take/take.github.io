---
layout: post
title: "Strong Parameters with accepts_nested_attributes_for"
date: 2013-01-08 17:33
tags: Rails
disqus: y
share: y
---

In Rails4, there will be a feature called "strong parameters" included in default.

The basic info about the strong parameters could be found [here](http://weblog.rubyonrails.org/2012/3/21/strong-parameters/).


So basically you write something like below, and decide which column could be changed when you use mass assignment.


{% highlight ruby %}
private
  # Using a private method to encapsulate the permissible parameters is just a good pattern
  # since you'll be able to reuse the same permit list between create and update. Also, you
  # can specialize this method with per-user checking of permissible attributes.
  def person_params
    params.required(:person).permit(:name, :age)
  end
{% endhighlight %}


So the important part is the below line.


{% highlight ruby %}
params.required(:person).permit(:name, :age)
{% endhighlight %}

First, you appoint which model you are going to use.
Then you permit which column is accessible by using the `permit` function, by giving the symbol names of columns.

But what are we going to do when we use `accepts_nested_attributes_for`?( btw, if you don't know what accepts_nested_attributes_for is, check this [post](/nested-object-forms-with-checkboxes/) ) 

When we use `accepts_nested_attributes_for` and assign nested models, basically the params goes like the below.

{% highlight ruby %}
"page"=>{"name"=>"aaaaaa",
        "desc"=>"aaaaaaaaaaaaaa",
        "images_attributes"
            =>{"0"=>{"image_name"=>"hoge"},
               "1"=>{"image_name"=>"piyo"}
                }
        }
{% endhighlight %}

So we have the get rid of the keys of the nested model.

There's a very good way to permit the nested models column.

{% highlight ruby %}
params.require(:page).permit(:name, :desc, images_attributes: :image_name)
{% endhighlight %}

That's it! :D

Btw the commit of this feature could be found in this [Pull Request](https://github.com/rails/strong_parameters/pull/25).
