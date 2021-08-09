library marganam.worker;

import 'dart:async';

/// SIngleton async (or not) function type
typedef FutureOr<T> ReadyOrNotWorker<T>();

/// Helper mixin to help defining a singleton function execution.
///
/// dart has no provision for async constructor. In case we need to execute an
/// async function before a class is actually usable (e.g. get data from web
/// through an async http get call & then parse the data & provide data). The
/// process complicates even further when the class is used with singleton
/// instance. The outside world would not have the intimation if such functions
/// have already been invoked or is currently under process. That's a awful lot
/// of code & messy state handling.
///
/// Example:
/// ```dart
/// /// A class designed for singleton use
/// class SomeClass with ReadyOrNotMixin {
///   // constructor
///   SomeClass._() {
///     // **attach the helper executer**
///     getReadyWorker = _initialize; // can be used with `super.` prefix, too
///   }
///
///   static SomeClass _cache = SomeClass._();
///   // factory to implement singleton instance
///   factory SomeClass() => _cache;
///
///   // this private value is set only if the [_initialize] function complete successfully
///   Object _asyncObject;
///
///   // thus, this publicly accessible [value] depends on the successful execution
///   // of [_initialize] & it only needs to happen once
///   Object get value => _asyncObject;
///
///   // the async job that need to be executed in singleton manner
///   Future _initialize() async {
///     _asyncObject = await someAsyncJob();
///   }
/// }
///
/// void main() async {
///   SomeClass someClass = SomeClass();
///
///   // either check before running
///   if (!someClass.ready) await someClass.getReady();
///   // or, it doesn't matter if someone has already run it or it's in progress
///   await someClass.getReady();
///
///   // now we're safe to use
///   someClass.value;
/// }
/// ```
mixin ReadyOrNotMixin<T> {
  bool _initialized = false;
  bool _working = false;
  FutureOr<T>? _future;

  /// Registers the [getReady] singleton job
  ReadyOrNotWorker<T>? getReadyWorker;

  /// Register additional singleton jobs
  final additionalSingleJobs = <String, ReadyOrNotWorker>{};
  final _workingJobs = Set<String>();
  final _workingFutures = <String, FutureOr>{};

  /// Whether the [getReady] has been executed ***once*** successfully or not
  bool get ready => _initialized;

  /// The singleton executor of [getReadyWorker]
  FutureOr getReady() async {
    if (null != getReadyWorker) {
      if (!_initialized && !_working) {
        _working = true;
        try {
          _future = getReadyWorker!();
          await _future;
          _initialized = true;
        } finally {
          _future = null;
          _working = false;
        }
      } else if (_working) await _future;
    }
  }

  /// Whether the [getReady] has been executed ***once*** successfully or not
  bool get working => _working || (_workingJobs.length > 0);

  /// The singleton executor of [additionalSingleJobs]
  FutureOr<R?> triggerJob<R>(String jobName, {bool onReady = false}) async {
    var shouldProceed = additionalSingleJobs.containsKey(jobName);
    if (shouldProceed) {
      final alreadyWorking = _workingJobs.contains(jobName);
      if (onReady) {
        shouldProceed = ready;
      }
      if (shouldProceed && !alreadyWorking) {
        _workingJobs.add(jobName);
        try {
          FutureOr<R> jobFuture =
              additionalSingleJobs[jobName]!() as FutureOr<R>;
          _workingFutures[jobName] = jobFuture;
          return await jobFuture;
        } finally {
          _workingFutures.remove(jobName);
          _workingJobs.remove(jobName);
        }
      } else if (alreadyWorking) {
        return await (_workingFutures[jobName] as FutureOr<R>);
      }
    }
    return null;
  }
}
