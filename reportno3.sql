select 
s.call_center as "Call Center",  /* call centers*/
count(s.name) as "Sales Order",  /* Total Sales Orders*/
count(case s.workflow_state when "Draft" then 1 end) as "Draft",   /*Status*/
count(case s.workflow_state when "Pending For Payment" then 1 end) as "Pending For Payment",
count(case s.workflow_state when "Discount Approval" then 1 end) as "Discount Approval",
count(case s.workflow_state when "AV Discount Approval" then 1 end) as "AV Discount Approval",
count(case s.status when "Dr Discount Approval" then 1 end) as "Dr Discount Approval",
count(case s.status when "Address Verification" then 1 end) as "Address Verification",
count(case s.status when "AV Hold" then 1 end) as "AV Hold",
count(case s.status when "Dr. Advice" then 1 end) as "Dr. Advice",
count(case s.status when "Dispatch" then 1 end) as "Dispatch",
count(case s.status when "Rejected" then 1 end) as "Rejected",
count(case s.status when "Delivered" then 1 end) as "Delivered",
count(case s.status when "Cancelled" then 1 end) as "Cancelled",
count(case s.status when "Returned" then 1 end) as "Returned",
count(case s.status when "Out for Pickup" then 1 end) as "Out for Pickup",


count(case when s.status != "Pincode Not Serviceable"
            and s.status != "On Hold"
            and s.status != "To Deliver and Bill"
            and s.status != "To Bill"
            and s.status != "To Deliver"
            and s.status != "Urgent Delivery" 
            and s.status != "Closed"
            and s.status != "Re Attempt" 
            and s.status != "Shipped" 
            and s.status != "Verification Pending"  then 1 end ) as "Other",
round(((count(case s.workflow_state when "Delivered" then 1 end)/count(name))*100),2 )as "Delivered Percentage(After AV)"
/*if(count(case s.workflow_state when "Delivered" then 1 end)/(count(name)-(count(case workflow_state when "Address Verification" then 1 end)+count(case workflow_state when "Rejected" then 1 end)))*100,count(case s.workflow_state when "Delivered" then 1 end)/(count(name)-(count(case workflow_state when "Address Verification" then 1 end)+count(case workflow_state when "Rejected" then 1 end)))*100,0) as "Delivered Percentage" */
from 
(select status,name,call_center,transaction_date from
`tabSales Order` ) as s
group by s.call_center