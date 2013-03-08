Foreman Katello Rails Engine
============================

Bringing Katello specific code into Foreman.

Installation
------------

Create `bundler.d/katello.rb` in your Foreman installation:

```ruby
gem 'deface', '~> 0.7.2'
gem 'foreman-katello-engine'
```

How it works?
-------------

The gem modifies some of the Foreman functionality to play nice with
Katello managed infrastructure. Often, just the HTML forms are
slightly modified using a `deface` gem, leveraging the Foreman data
model to model Katello entities.

Modified functionality
----------------------

### Host Group forms

New tab 'Katello' is added to the host groups form, exposing a select
box for katello environment and activation keys.

Katello Environment is modeled by Foreman organizations. For now, a
naming convention makes it possible to identify Katello specific
organizations like this:

```
Foreman Organization       | Katello Entity
-----------------------------------------------------------------
kt-[ACME_Corporation]      | organization ACME_Corporation
kt-[ACME_Corporation][Dev] | environment Dev in ACME_Corporation
```

These organizations are hidden from the 'Organizations' tab and put
into the 'Katello Environment' select box. Before submitting the form,
the changed are reflected back to the Foreman organizations
checkboxes.

The activation keys are modeled similarly using foreman custom params.
The value entered into 'Activation Keys' is saved as
`kt_activation_keys` custom parameter and can be used in the kickstart
template like other parameters.

The activation keys are autocompleted for better user experience and
the list of products for each used activation key is displayed at the
bottom of the Katello tab.

### Katello-friendly provisioning

To register a provisioned system to katello a new provisioning
template snippet needs to be crated, lets call it katello:

```
<% if @host.params['kt_activation_keys'] %>
rpm -ivh "http://katello.example.com/pub/candlepin-cert-consumer-katello.example.com-1.0-1.noarch.rpm"
subscription-manager register --org "<%= @host.params['kt_org'] %>" --activationkey "<%= @host.params['kt_activation_keys'] %>"
<% end %>
```

and reference it from the kickstart template:

```
<%= snippets "katello" %>
```

Current status
--------------

Highly experimental.

The values for activation keys are not synced from actual Katello
instance, just some test values.

Licence
-------

GPLv2
