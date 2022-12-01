// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package com.example.alternate_language_test_plugin;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import com.example.alternate_language_test_plugin.CoreTests.AllTypes;
import com.example.alternate_language_test_plugin.CoreTests.AllTypesWrapper;
import com.example.alternate_language_test_plugin.CoreTests.HostIntegrationCoreApi;
import io.flutter.embedding.engine.plugins.FlutterPlugin;

/** This plugin handles the native side of the integration tests in example/integration_test/. */
public class AlternateLanguageTestPlugin implements FlutterPlugin, HostIntegrationCoreApi {
  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
    HostIntegrationCoreApi.setup(binding.getBinaryMessenger(), this);
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {}

  // HostIntegrationCoreApi

  @Override
  public void noop() {}

  @Override
  public @NonNull AllTypes echoAllTypes(@NonNull AllTypes everything) {
    return everything;
  }

  @Override
  public void throwError() {
    throw new RuntimeException("An error");
  }

  @Override
  public @Nullable String extractNestedString(@NonNull AllTypesWrapper wrapper) {
    return wrapper.getValues().getAString();
  }

  @Override
  public @NonNull AllTypesWrapper createNestedString(@NonNull String string) {
    AllTypes innerObject = new AllTypes.Builder().setAString(string).build();
    return new AllTypesWrapper.Builder().setValues(innerObject).build();
  }
}
