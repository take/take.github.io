---
layout: post
title: "What's yield?(for ruby newbies)"
date: 2012-10-25 21:20
comments: true
categories: Ruby
---

When we're using Ruby, we often use blocks. Like the code below.

{% highlight ruby %}
nums = [1, 2, 3, 4]

nums.collect! do |n|
  n ** 2
end

puts nums.inspect # => [1, 4, 9, 16]
{% endhighlight %}


For a Ruby newbie like me, this was like wtf.

I used to be a PHPer, well not a good PHPer.
So the block concept was really new for me.

I thought of writing a post about it, but I found a really good article about the explanations of Blocks, Yields, Procs, and Lambdas over [here](http://www.robertsosinski.com/2008/12/21/understanding-ruby-blocks-procs-and-lambdas/).

You should really read it if your new to Ruby.

I used to be a PHPer, well a crappy PHPer.
And in my opinion, Ruby is really awesome.
You can do more stuff with less codes.

Engineers are born to make things automated, don't repeat yourself :).
