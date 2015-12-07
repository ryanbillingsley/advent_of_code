# Day6

When I first started working on this I was convinced that a Set was the right way
to go.  HashSet was really fast, but I wanted to add multiple instances of each
coordinate when I turned one on or toggled it, so I decided to try a List.  List
proved to be way too slow.  It would have worked eventually, but I wanted to see
if I could do better.

The next thing I looked into was using Agents and Tasks to try and process the
set of instructions async.  This still wasn't working quite how I worked so I
tried some different storage mechanism for the Agent.  Eventually I landed on HashDict.

The real problem emerged after running some test runs.  On small data sets, everything
seemed to work.  However, when I ran it against the full input, the results started
to wander.  I would get different values for my final count.

To make sure I wasn't just wrong with my code, I switched it back to a synchronous
approach but still using the Agent.  That ended up solving the problem.

I tried the async Task again, but the result was different.  Then it occured to me:
in order to get the async to work, I would have to acculated all of the deltas on
each coordinate, and then play them back to get the correct answer.  Because the
brightness level could not go below 0, the order of `remove` actions could cause
the results to vary depending on how they resolved.

