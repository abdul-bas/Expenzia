abstract class CreditEvent {
  const CreditEvent();
}

class LoadCreditsEvent extends CreditEvent {
  const LoadCreditsEvent();
}

class ChangeCreditTypeEvent extends CreditEvent {
  final String creditType;

  const ChangeCreditTypeEvent(this.creditType);
}

class ChangePlanTypeEvent extends CreditEvent {
  final String planType;

  const ChangePlanTypeEvent(this.planType);
}

class ChangeCreditDateEvent extends CreditEvent {
  final DateTime date;

  const ChangeCreditDateEvent(this.date);
}

class SubmitCreditEvent extends CreditEvent {
  final String toName;
  final String amountString;

  const SubmitCreditEvent({
    required this.toName,
    required this.amountString,
  });
}

class DeleteCreditEvent extends CreditEvent {
  final int id;

  const DeleteCreditEvent(this.id);
}
