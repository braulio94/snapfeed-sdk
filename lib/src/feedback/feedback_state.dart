import 'dart:ui';

import 'package:snapfeed/src/common/theme.dart';
import 'package:snapfeed/src/feedback/feedback_ui_state.dart';

class SnapfeedFeedbackState {
  SnapfeedFeedbackState({
    FeedbackUiState uiState,
    Color penColor,
  })  : uiState = uiState ?? FeedbackUiState.navigate,
        penColor = penColor ?? SnapfeedTheme.penColors[0];

  SnapfeedFeedbackState copyWith({
    FeedbackUiState uiState,
    Color penColor,
  }) {
    return SnapfeedFeedbackState(
      uiState: uiState ?? this.uiState,
      penColor: penColor ?? this.penColor,
    );
  }

  final FeedbackUiState uiState;
  final Color penColor;
}
