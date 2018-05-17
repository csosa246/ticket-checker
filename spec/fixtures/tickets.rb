@ticket = @port_chester.tickets.create!(user_id: @admin.id, violation_id: 12324, amount: 1254, status: 'unpaid', description: 'This was a fire hydrant violation')

