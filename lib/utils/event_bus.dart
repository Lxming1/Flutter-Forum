import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class RebuildEvent{
  late int momentId;
  RebuildEvent(this.momentId);
}