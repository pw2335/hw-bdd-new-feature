# CHIP 7.9: Using BDD to Drive a New Feature

In a previous assignment, you practiced creating Cucumber steps and
step definitions to test an existing app, as a way of getting practice
with how Cucumber acceptance tests work.

But in real BDD, it is the other way around--you write the Cucumber
scenarios and steps _before_ the app, watch the steps fail, and then
add code to make one step at a time pass.  That is, the _behavior_
described in the steps should _drive the development_ of the code that
implements that behavior. Importantly, the Cucumber steps
**only** describe what the observed behavior should be, rarely saying
anything about **how** the behavior is implemented.

In this assignment you will start from Cucumber scenarios that fail
because they are trying to acceptance-test features that haven't been
implemented yet, and one step at a time, you will write the code that
makes those steps pass.  The idea is that we are adding a  "find
movies with same director" feature to RottenPotatoes, and these new
scenarios are supposed to test that feature.


## Learning Goals

After you complete this assignment, you should be able to:
* Create and run simple Cucumber scenarios to test a new feature
* Understand where to modify a Rails app to implement the various parts of a new feature, since a new feature often touches the database schema, model(s), view(s), and controller(s)
* Use the failing scenario step to drive those modifications and
ultimately make the Cucumber scenarios pass, thereby validating the
high-level behavior of the new feature

## Get the assignment code

[Create a copy of the repository on your GitHub account.][generate]

We recommend you name your repo `hw-bdd-new-feature`. **Remember to mark the repository as Private.**

[generate]: https://github.com/saasbook/hw-bdd-new-feature/generate

Then clone the repo to Codio:

```sh
git clone git@github.com:[your_github_username]/hw-bdd-new-feature.git
```

(You can also go to your github repo for this assignment and click the green **code** button and copy the url. Then type `git clone` in codio terminal and paste the url and add `rottenpotatoes` after it.)

**⚠️ Your directory must be named `hw-bdd-new-feature`.**

You can also [explore the repo on GitHub][repo].

[repo]: https://github.com/saasbook/hw-bdd-new-feature

### 📌 Tip: Use git tags

We recommend that you make a commit as soon as you get each part working.

As an optional additional help, git allows you to associate
tags--symbolic names--with particular commits. For example,
immediately after doing a commit, you could run `git tag part1b`, and
thereafter you could use `git diff part1b` to see differences since
that commit, rather than remembering its commit ID. Note that after
creating a tag in your local repo, you need to use `git push origin
--tags` to push the tags to your remote.
(Tags are ignored by deployment remotes such as Heroku, so
there's no point in pushing tags there.)

> _Note_: Publishing your homework to a public repo is against the Honor Code.


### Run and Prep rottenpotatoes

Once you have the clone of the repo:

1. Change into the rottenpotatoes directory: `cd hw-bdd-new-feature`

2. Run `bundle install --without production` to make sure all gems are properly installed.

   **NOTE:** If Bundler complains that the wrong Ruby version is installed, verify that `rvm` is installed (for example, `rvm --version`) and say `rvm list` to see which Ruby versions are available and `rvm use `_version_ to make a particular version active.  If no versions satisfying the Gemfile dependency are installed, you can say `rvm install `_version_ to install a new version, then `rvm use `_version_ to use it.  Then you can try `bundle install` again.

3. Create the initial database schema:
```shell
bundle exec rails db:migrate
bundle exec rails db:test:prepare
```

4. You can optionally add some seed data in `db/seeds.rb` and run `rails db:seed` to add it.

5. Double check that Cucumber is correctly set up by running `cucumber`. We've provided a couple of scenarios that will fail, which you can use as a starting point, in `features/movies_by_director.feature`.

<details>
    <summary>
    What is the first failure Cucumber reports?  Reading the error
    message carefully, what is the cause of this specific failure, and
    what should you modify to make progress?  <b>HINT:</b> Start
    reading at the <b>beginning</b> of the trace and look for
    the <b>first</b> place where you see an actual error string, rather than a
    warning or informational log message.  Cucumber even prints these
    in red.  Take note of what part of the system the error is coming
    from (a file in your app? a part of Rails? etc.)
    <p><blockquote>
    The Cucumber test is trying to load some movie data into the test
    database including a movie director, but the existing definition
    of a movie doesn't have a director field.  You need to create and
    apply a migration to add this attribute.
    </blockquote></p>
</details>

Go on to the next part to modify your app to get past this error.
