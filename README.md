# fake.results
Create random (fake) election results
=====================================

Description
------------------

This function produces a set of random election results, over multiple years, chambers and districts. It allows to manipulate the number of parties, districts and election cycles.


Availability
------------------

The script can be called directly from the repository:
<pre><code>source("https://raw.github.com/santiago-alles/enp.script/master/random_results.r")</code></pre>

Usage
------------------

<pre><code>results.FUN( parties, num.districts, chambers = c("lower", "upper") , years )</code></pre>

Arguments
------------------

<code>parties</code> A vector of party labels to be used in the data generation. If not defined, fake labels will be used.

<code>num.districts</code> Number of electoral districts. If not defined, a random number of districts will be used.

<code>chambers</code> A vector of legislative chambers. If not defined, <code>chambers = c("lower", "upper")</code>.

<code>years</code> List of election years. If not defined, a random list of election years will be used.

Required packages 
------------------

<pre><code>doBy</pre></code>
<pre><code>dplyr</pre></code>

If not installed, the function will try to install them.


