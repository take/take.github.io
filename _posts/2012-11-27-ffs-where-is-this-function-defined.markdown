---
layout: post
title: "Ffs where is this function defined?"
date: 2012-11-27 15:05
comments: true
categories: Rails
---

versions: Ruby 1.9.3

When I'm building an app with Rails, I sometimes want to know where exactly is this method defined.

Like when I was using `current_page?` view helper, I wanted to check the code of it, and check what happens if I added some code to it.

When u write `method(:current_page?).source_location`, you'll get where the function is defined like below.

{% highlight bash %}
["/Users/Takehiro/.rvm/gems/ruby-1.9.3-p194/gems/actionpack-3.2.8/lib/action_view/helpers/url_helper.rb", 588]
{% endhighlight %}

Pretty useful.
