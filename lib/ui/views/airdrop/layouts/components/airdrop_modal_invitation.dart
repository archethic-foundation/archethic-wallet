import 'package:aewallet/model/airdrop.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_footer_primary.dart';
import 'package:aewallet/ui/figma_components/buttons/btn_textfield.dart';
import 'package:aewallet/ui/figma_components/custom_styles.dart';
import 'package:aewallet/ui/themes/archethic_theme.dart';
import 'package:aewallet/ui/util/ui_util.dart';
import 'package:aewallet/ui/views/airdrop/bloc/provider.dart';
import 'package:aewallet/ui/widgets/components/scrollbar.dart';
import 'package:archethic_dapp_framework_flutter/archethic_dapp_framework_flutter.dart'
    as aedappfm;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:url_launcher/url_launcher.dart';

class AirdropModalInvitation extends ConsumerWidget {
  const AirdropModalInvitation({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = AppLocalizations.of(context)!;
    final airdropForm = ref.watch(airdropFormNotifierProvider);
    final controller = TextEditingController(text: airdropForm.referralCode);
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: ArchethicScrollbar(
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 20,
                  bottom: 120,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          localizations.airdropInvitationTitle,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                fontSize: 20,
                                fontWeight: FontWeightTelegraf.fontWeightBold,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Text(
                      localizations.airdropInvitationDesc,
                      style: Theme.of(context).textTheme.bodyMediumWithOpacity,
                    ),
                    const SizedBox(height: 30),
                    if (airdropForm.referralCode != null)
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              localizations.airdropInvitationDescCodeTitle,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight:
                                        FontWeightTelegraf.fontWeightSemibold,
                                  ),
                            ),
                            const SizedBox(height: 15),
                            Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                TextField(
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  autocorrect: false,
                                  controller: controller,
                                  textAlign: TextAlign.left,
                                  textInputAction: TextInputAction.done,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor:
                                        Colors.white.withValues(alpha: 0.15),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    focusColor: Colors.white,
                                    contentPadding:
                                        const EdgeInsets.only(left: 10),
                                  ),
                                ),
                                Positioned(
                                  right: 10,
                                  child: BtnTextField(
                                    buttonText: const Icon(
                                      aedappfm.Iconsax.copy,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    onTap: () async {
                                      await Clipboard.setData(
                                        ClipboardData(
                                          text: airdropForm.referralCode!,
                                        ),
                                      );
                                      UIUtil.showSnackbar(
                                        localizations.codeCopied,
                                        context,
                                        ref,
                                        ArchethicTheme.text,
                                        ArchethicTheme.snackBarShadow,
                                        icon: Symbols.info,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 30),
                    Text(
                      localizations.airdropInvitationMessageTitle,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeightTelegraf.fontWeightSemibold,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            aedappfm.BlockInfo(
                              width: MediaQuery.of(context).size.width - 40,
                              paddingEdgeInsetsClipRRect: EdgeInsets.zero,
                              paddingEdgeInsetsInfo: const EdgeInsets.all(20),
                              info: Column(
                                spacing: 10,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        localizations
                                            .airdropInvitationMessageDesc1(
                                          airdropForm.referralCode ?? '?',
                                        ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                              fontFamily: aedappfm
                                                  .AppThemeBase.addressFont,
                                            ),
                                      ),
                                      InkWell(
                                        child: Row(
                                          children: [
                                            Text(
                                              kAirdropArchethicWebsiteUrl,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    fontFamily: aedappfm
                                                        .AppThemeBase
                                                        .addressFont,
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        onTap: () async {
                                          await launchUrl(
                                            Uri.parse(
                                              kAirdropArchethicWebsiteUrl,
                                            ),
                                            mode:
                                                LaunchMode.externalApplication,
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  Text(
                                    localizations.airdropInvitationMessageDesc2,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          fontFamily:
                                              aedappfm.AppThemeBase.addressFont,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ],
                    ),
                    BtnFooterPrimary(
                      buttonText: localizations.airdropInvitationBtnCopy,
                      onTap: () async {
                        await Clipboard.setData(
                          ClipboardData(
                            text:
                                '${localizations.airdropInvitationMessageDesc1(airdropForm.referralCode ?? '')}\n$kAirdropArchethicWebsiteUrl\n\n${localizations.airdropInvitationMessageDesc2}',
                          ),
                        );
                        UIUtil.showSnackbar(
                          localizations.messageCopied,
                          context,
                          ref,
                          ArchethicTheme.text,
                          ArchethicTheme.snackBarShadow,
                          icon: Symbols.info,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: IconButton(
            onPressed: () async {
              context.pop();
            },
            icon: const Icon(
              Symbols.close,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
      ],
    );
  }
}
