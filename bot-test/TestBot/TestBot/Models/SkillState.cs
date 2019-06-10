// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.

using Luis;

namespace TestBot.Models
{
	public class SkillState
	{
		public string Token { get; internal set; }

		public TestBotLuis LuisResult { get; internal set; }

		public void Clear()
		{
		}
	}
}
