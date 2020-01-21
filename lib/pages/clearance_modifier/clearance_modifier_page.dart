import 'package:dwimay/pages/clearance_modifier/clearance_modifier_form.dart';
import 'package:dwimay/strings.dart';
import 'package:dwimay/widgets/build_button.dart';
import 'package:dwimay/widgets/confirmation_dialog.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';

/// The page where the user can modify clearance level of 
/// users.
class ClearanceModifier extends StatelessWidget {

  /// The function to execute when the backbutton is pressed
  final void Function() onBackPress;

  /// The key for the form
  final GlobalKey<ClearanceModifierFormState> formKey;

  ClearanceModifier({@required this.onBackPress}) : 
    formKey = GlobalKey<ClearanceModifierFormState>();

  @override
  Widget build(BuildContext context) {
    // The combination of [LayoutBuilder], [SingleChildScrollView], [ConstrainedBox]
    // and [IntrinsicHeight] is used so that [Expanded] can be used inside a 
    // [SingleChildScrollView].
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0, left: 20.0, right: 20.0),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) => 
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[

                    // title
                    Text(
                      Strings.clearancePageTitle,
                      style: Theme.of(context).textTheme.title.copyWith(
                        color: Colors.white
                      ),
                    ),

                    // the forms
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: ClearanceModifierForm(
                          key: formKey,
                          onSaved: (String email, int clearance) =>
                            _onSaved(context, email, clearance),
                        ),
                      ),
                    ),

                    // the back and submit button
                    _buttonBar(),
                  ],
                ),
              ),
            )
          ),
      ),
    );
  }

  /// shows the confirmation dialog
  void _onSaved(BuildContext context, String email, int clearance) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => 
        ConfirmationDialog(
          title: Strings.clearancePageTitle,
          successMessage: Strings.clearancePageSuccess,
          useSnapshotErrorMessage: true,
          future: () async {
            await CloudFunctions.instance.updateClearanceForUser(
              email: email,
              clearance: clearance
            );

            // returning true to indicate success
            return true;
          }
        )
    );
  }

  /// the back and submit buttons
  Widget _buttonBar() => 
    // Back button
    Row(
      children: <Widget>[
        // back button
        SizedBox(
          width: 120,
          child: BuildButton(
            data: Strings.backButton,
            onPressed: onBackPress,
          ),
        ),

        // center gap
        Expanded(child: Container(),),

        // the confirm button
        SizedBox(
          width: 120,
          child: BuildButton(
            data: Strings.confirmButton,
            onPressed: () => formKey.currentState.saveForm(),
          ),
        ),
      ],
    );
}