select 
s.call_center as "Call Center",  /* call centers*/
count(s.name) as "Sales Order",  /* Total Sales Orders*/
count(case s.workflow_state when "Draft" then 1 end) as "Draft",   /*Status*/
count(case s.workflow_state when "Pending For Payment" then 1 end) as "Pending For Payment",
count(case s.workflow_state when "Discount Approval" then 1 end) as "Discount Approval",
count(case s.workflow_state when "AV Discount Approval" then 1 end) as "AV Discount Approval",
count(case s.workflow_state when "Dr Discount Approval" then 1 end) as "Dr Discount Approval",
count(case s.workflow_state when "Address Verification" then 1 end) as "Address Verification",
count(case s.workflow_state when "AV Hold" then 1 end) as "AV Hold",
count(case s.workflow_state when "Dr. Advice" then 1 end) as "Dr. Advice",
count(case s.workflow_state when "Dispatch" then 1 end) as "Dispatch",
count(case s.workflow_state when "Rejected" then 1 end) as "Rejected",
count(case s.workflow_state when "Delivered" then 1 end) as "Delivered",
count(case s.workflow_state when "Cancelled" then 1 end) as "Cancelled",
count(case s.workflow_state when "Returned" then 1 end) as "Returned",
count(case s.workflow_state when "Out for Pickup" then 1 end) as "Out for Pickup",
(case when s.workflow_state != "Pincode Not Serviceable"
            and s.workflow_state != "On Hold"
            and s.workflow_state != "To Deliver and Bill"
            and s.workflow_state != "To Bill"
            and s.workflow_state != "To Deliver"
            and s.workflow_state != "Urgent Delivery" 
            and s.workflow_state != "Closed"
            and s.workflow_state != "Re Attempt" 
            and s.workflow_state != "Shipped" 
            and s.workflow_state != "Verification Pending"  then 1 end ) as "Othernnbhbs",
round(((count(case s.workflow_state when "Delivered" then 1 end)/count(name))*100),2 )as "Delivered Percentage(After AV)"
/*if(count(case s.workflow_state when "Delivered" then 1 end)/(count(name)-(count(case workflow_state when "Address Verification" then 1 end)+count(case workflow_state when "Rejected" then 1 end)))*100,count(case s.workflow_state when "Delivered" then 1 end)/(count(name)-(count(case workflow_state when "Address Verification" then 1 end)+count(case workflow_state when "Rejected" then 1 end)))*100,0) as "Delivered Percentage" */
from 
(select so.workflow_state as "workflow_state", so.name as "name", so.call_center as "call_center", so.transaction_date as "transaction_date"
from
`tabSales Order` so ) as s

group by s.call_center