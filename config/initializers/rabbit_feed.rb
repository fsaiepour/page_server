# Define the events (if producing)
EventDefinitions do
  define_event('browser_call_request', version: '1.0.0') do
    defined_as do
      'A call has been requested by client'
    end
    payload_contains do
      field('worker_id', type: 'string', definition: 'The worker ID')
    end
  end
end
