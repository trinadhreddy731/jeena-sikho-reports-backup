select 
so.name as "Name",
(so.workflow_state = "Draft" then 1 end) as "Draft",
(so.workflow_state = "On Hold" then 1 end) as "On Hold",
(so.workflow_state = "To Deliver And Bill" then 1 end) as "To Deliver And Bill",
(so.workflow_state = "To Bill" then 1 end) as "To Bill",
(so.workflow_state = "To Deliver" then 1 end) as "To Deliver",
(so.workflow_state = "Completed" then 1 end) as "Completed",
(so.workflow_state = "Cacelled" then 1 end) as "Cacelled",
(so.workflow_state = "Closed" then 1 end) as "Closed"
from `tabSales Order` so
group by 
so.name