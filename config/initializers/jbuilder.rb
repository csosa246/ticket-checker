class Jbuilder
  def resource!(*args, url: , &block)
    resource_proc!(*args, url: url, &block).call
  end

  def collection_resource!(*args, url: , &block)
    resource_proc!(*args, url: url, collection: true, &block).call
  end

  private

  def current_user
    @context.controller.current_user
  end

  def resource_proc!(path, resource, url: , collection: false, &block)
    content_proc = content_proc!(resource, url, collection, block)
    path.to_s.split('/').reverse.inject(content_proc) do |proc, path_component|
      ->(*) { __send__(path_component, &proc) }
    end
  end

  def content_proc!(resource, url, collection, block)
    ->(*) do
      actions = authorized_actions_for!(current_user, resource, collection)
      if actions.any?
        url(url)
        auth(actions)
      end
      block&.call
    end
  end

  def authorized_actions_for!(user, resource, collection)
    policy = collection ? collection_policy_for!(user, resource) : policy_for!(user, resource)
    base_actions(collection).select { |action| policy.public_send(:"#{action}?") }
  end

  def collection_policy_for!(*args)
    ::Pundit.policy!(*args).tap do |policy|
      policy.instance_eval { alias read? index? }
    end
  end

  def policy_for!(*args)
    ::Pundit.policy!(*args).tap do |policy|
      policy.instance_eval { alias read? show? }
    end
  end

  def base_actions(collection)
    collection ? %w(read create) : %w(read update destroy)
  end
end

Jbuilder.key_format camelize: :lower

