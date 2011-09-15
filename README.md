# MailEnvi

A basic Mail interceptor gem for (Rails 3) development and other environments.

### Basic Usage

**Install**

    gem "mail_envi"

That is about it.

While, you can configure the MailEnvi to work within any environment. For most basic uses, I recommend you keep this gem under your `development` group in your `Gemfile`.

---

Intercepted mail will, by default, change the `to` address to `root@localhost` and will prefix the subject to identify it was intercepted.

Ex:

    # original mail
    to: foo@bar.com
    subject: Hello World

    # intercepted mail
    to: root@localhost
    subject: (#{Rails.env} Intercepted) Hello World

---

**Configuration**

There are a few configuration options you can provide to extend/customize the functionality of MailEnvi.

In your `initializer/mail_envi.rb`

    MailEnvi::Config.set do |config|
      config.interceptor = CustomInterceptorClass
      config.default_to  = "person@company.com"
      config.include_environments [:beta, :alpha]
    end


<table border="1" cellspacing="0">
  <col align="left" />
  <col align="left" />
  <col align="left" />
  <thead>
    <tr>
      <th>key</th>
      <th>accepted value</th>
      <th>description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>interceptor</td>
      <td>Class</td>
      <td>You can provide a custom interceptor class to provide customized interception &ldquo;your way&rdquo;.</td>
    </tr>
    <tr>
      <td>default_to</td>
      <td>String</td>
      <td>Replace the <code>DefaultInterceptor</code>&rsquo;s <code>to</code> address, to one set in the config. <strong>Only works through the <code>DefaultInterceptor</code></strong></td>
    </tr>
    <tr>
      <td>include_environments</td>
      <td>Array</td>
      <td>Adds the array, to the list of included environments that should register the interceptor</td>
    </tr>
  </tbody>
</table>

### Inspirations

* Ryan Bates' [Action Mailer in Rails 3][0] railscast. Thanks!

  [0]: http://railscasts.com/episodes/206-action-mailer-in-rails-3


## TODO

* Test helpers
* Multi-environment configurations

### Contributing to mail_envi

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

### Copyright

Copyright (c) 2011 Yung Hwa Kwon. See LICENSE.txt for
further details.

