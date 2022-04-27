select distinct top 5 count(r.receipt_id), b.brandCode
from brands as b join receiptItemList as r on (b.brandCode = r.brandCode and b.cpq_id = r.rewardsProductPartnerId)
group by b.brandCode;