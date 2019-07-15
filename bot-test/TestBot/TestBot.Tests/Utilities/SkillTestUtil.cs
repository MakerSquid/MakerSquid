// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.

using System.Collections.Generic;
using Luis;
using Microsoft.Bot.Builder;
using Microsoft.Bot.Builder.Solutions.Testing.Mocks;
using TestBot.Tests.Utterances;

namespace TestBot.Tests.Utilities
{
	public class SkillTestUtil
	{
		private static Dictionary<string, IRecognizerConvert> _utterances = new Dictionary<string, IRecognizerConvert>
		{
			{ SampleDialogUtterances.Trigger, CreateIntent(SampleDialogUtterances.Trigger, TestBotLuis.Intent.Sample) },
		};

		public static MockLuisRecognizer CreateRecognizer()
		{
			var recognizer = new MockLuisRecognizer(defaultIntent: CreateIntent(string.Empty, TestBotLuis.Intent.None));
			recognizer.RegisterUtterances(_utterances);
			return recognizer;
		}

		public static TestBotLuis CreateIntent(string userInput, TestBotLuis.Intent intent)
		{
			var result = new TestBotLuis
			{
				Text = userInput,
				Intents = new Dictionary<TestBotLuis.Intent, IntentScore>()
			};

			result.Intents.Add(intent, new IntentScore() { Score = 0.9 });

			result.Entities = new TestBotLuis._Entities
			{
				_instance = new TestBotLuis._Entities._Instance()
			};

			return result;
		}
	}
}
