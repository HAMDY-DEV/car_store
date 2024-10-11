  int isDays(auctionItem) {
    DateTime selectedDate = DateTime.parse(auctionItem.selectedDate);
    int days = selectedDate.difference(DateTime.now()).inDays;
    return days;
  }

  int isHours(auctionItem) {
    DateTime selectedDate = DateTime.parse(auctionItem.selectedDate);
    int hour = selectedDate.difference(DateTime.now()).inHours;
    return hour;
  }